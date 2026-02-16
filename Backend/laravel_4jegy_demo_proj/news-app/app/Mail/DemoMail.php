<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class DemoMail extends Mailable
{
    use Queueable, SerializesModels;

    public $mailData; // Ebbe tesszük az adatokat

    // Konstruktor: itt kapjuk meg az adatokat
    public function __construct($mailData)
    {
        $this->mailData = $mailData;
    }

    // A boríték beállítása (Tárgy)
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Teszt Levél a Laravelből', // Az email tárgya
        );
    }

    // A tartalom beállítása (Melyik View fájlt használja?)
    public function content(): Content
    {
        return new Content(
            view: 'emails.demo', // Ezt a fájlt mindjárt létrehozzuk [cite: 101]
        );
    }

    public function attachments(): array
    {
        return [];
    }
}
