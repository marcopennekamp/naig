library naig;

import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;

import 'package:naig/resident.dart';
import 'package:naig/resource.dart';
import 'package:naig/Time.dart';
import 'package:naig/render.dart';

final Game game = new Game ();
final Random random = new Random ();

class Game {

    static const int kMaxNotifications = 10;

    Date date = new Date (1400, 1);
    ResourceManager resourceManager;
    List<Resident> residents = new List ();

    bool _inTick = false;

    void init () {
        bool loadedSave = load ();
        if (!loadedSave) {
            resourceManager = new ResourceManager ();
        }

        querySelector ('#tick').addEventListener ('click', tickButtonClicked);

        residents.add (new Resident ());

        render ();
    }

    void tickButtonClicked (Event e) {
        if (_inTick) return;
        _inTick = true;

        ButtonElement button = querySelector ('#tick');
        button.disabled = true;

        tick ();

        button.disabled = false;
        _inTick = false;
    }

    void tick () {
        displayNotification (date.notification ());

        /* Update residents. */
        for (var resident in residents) {
            resident.tick ();
        }

        render ();

        date.advance ();

        save ();
    }

    void render () {
        /* Render residents. */
        renderIterable (querySelector ('#residents'), residents);

        /* Render resources. */
        resourceManager.render ();
    }

    void save () {
        String json = toJson ();
        window.localStorage['naig-save'] = json;
    }

    /**
     * return: Whether a save existed.
     */
    bool load () {
        String json = window.localStorage['naig-save'];
        if (json != null) {
            fromJson (json);
            return true;
        }
        return false;
    }

    void displayNotification (String message) {
        Element notifications = querySelector ('#notifications');
        SpanElement element = new SpanElement();
        element.text = message;
        notifications.insertAdjacentElement('afterBegin', element);

        while (notifications.children.length > kMaxNotifications) {
            notifications.children.last.remove();
        }
    }

    String toJson () {
        return JSON.encode ({'resourceManager': resourceManager.toEncodable ()});
    }

    void fromJson (String json) {
        Map map = JSON.decode (json);
        resourceManager = ResourceManager.fromEncodable (map['resourceManager']);
    }

}
