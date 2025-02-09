Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE4A2DE47
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Feb 2025 15:29:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YrVTr38dhz3050
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 01:29:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739111390;
	cv=none; b=IqoAcyjo/1S/NQgk0BDllG/kko0iI02r+2UnPZ8E1m473imIGhIRuPD99Or+mU8wY3d7CKGwKFSDcI63ufS9UzSJ/6r/kC04KebC/jq7pi74n5i+WxZY5WEwCvekwM46DDAHyKFPmOTzCOepyEhUsvA3qG571dN7Fc9nnyGSSoxlfsiGqtB/tlAAODc60sBYtZhfVGS1oJ6He4o9U6ZNOzakp4wVMEWJQUxSGEyeLeoH1vqL27CYQC9PY0gtjXB/eHisAhHkrKjRCzAtH4uMkBZGe8AGdajUd5BF8uRxpW5SOxowihUiCr0zDIS6XLcTC3MElDk/vkzeAXFkVdax2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739111390; c=relaxed/relaxed;
	bh=/qsWqBZBBCCyXwhdujQ81uWXFemxOEY+TnQjhDgbmf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4F94uSHPMT2PW6VYtLwcxs7BxOcfEy/m6NLrthebCYvnj+lEjlvutuEEp1+bQnaxsmoootMPGH15/I9SsC/RoQ6qk3hShfZY8HfETgozocweTNWCt86KlTIivJ+f9eBChq5IM6uN72iP76c93LX485qjgStaHakaVTFC5SyyS/XBrBXkUuODQvVpov9cl/soRZ6fSPkZ6YHB8RgotJBZdpGtR4E/gGBMXKCsYGqyVmoI642FHMOn/x+HQcK5QIu5v8Q+kJMVgrpUiZfdt3cHv2fboZLpQstHISAFRnFhYhPu+tendNEQzufMROzHQ/frPVWuGNSajRwGZGTATG5VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ORZLQtSI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ORZLQtSI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YrVTn32VKz2xy0
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 01:29:48 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so6491165a91.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Feb 2025 06:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739111385; x=1739716185; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qsWqBZBBCCyXwhdujQ81uWXFemxOEY+TnQjhDgbmf0=;
        b=ORZLQtSIkpkPwI1Rro78FDMQJNY8Cf1Kl59I6EYn2PWXfYqO8NTO1XXOONoBDgVql/
         5g9vdvjBnyDGTHloDGmeThGtrSE9qQALtOkn8Se9oisrUANyV1Ur59zXCrbIuhf0nk73
         GwBmVtr91uGxmtDe4Jo2RyKPC2iRE9Pu+4mzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739111385; x=1739716185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qsWqBZBBCCyXwhdujQ81uWXFemxOEY+TnQjhDgbmf0=;
        b=Z5QyYT2mmB6jyuTwLr8RcVCPlaCNZQUYWzJb22spABqpLDT/+uCW5OVUxQEQrvhlPs
         m10vfRwC4ze+HD/jz6L4svhqX1hRqfady0nQHmEu+ceZRXAvtsdBNrnVV/7WoSjBLyGg
         owvW4ehC+fNaNdwXe7Bu5t/asg2Y0LHb3dM06xyA95N0geDsdSzgdCgP65HedtNu2S91
         ILRaD5TBBtPvJxHlz2FcebB8FF5/pbkCCnNEdsN56BnZvGynZV/1/AS+BWLOeFrD5bcw
         /zQMRXp3mryiWz1cujUyKKVojngSJWC+VtK/A4KEiizHkBNllobQaVhUfZ/pwZsZkehN
         udHw==
X-Forwarded-Encrypted: i=1; AJvYcCU07IUirdDnW6Y0BaMVhZMVbjsTflLxlQcgEgOrMhOZc8Pbjk2P5eFnAb/XtuNxNTttJDV/rFf7lne8Nw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYS1OkkWrQGFqGcNlUSE6EAhDy2CEjSvCECCKbBFfowa9h8H1R
	HoWxq5naTGdQWR1XhLdpmPy4Cn8vlQh1GMKUCwQDQF2LXmwMypxwGVwtcDHmSlltZGSyp6cdws8
	aLStxTxNB48Ty9oYD4tykWBI/ct5EXb8LVUWE
X-Gm-Gg: ASbGncs3SHZU3eYE3q7QHLUUUIN31TVh+LwOuLCUy9rICAcXOSqMnTT3k1RTHg86Z4X
	oxzobF7hdsd9eo2HIH8Gh45E7Lc59ApOdL5Pdg5qAHERkWguZM9M1bNBzQrVTRWkm4BQ8I+b8Rw
	==
X-Google-Smtp-Source: AGHT+IGv8+ch5sjc+/6GxKPnjM9U0T7CaoK8Xj3VdIUlcClSiubNUhIf7u+ytB5/VeAh0Paa7FQVFeOJfX+vDEaLNms=
X-Received: by 2002:a17:90b:1806:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2fa2427064fmr14324146a91.21.1739111385381; Sun, 09 Feb 2025
 06:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org> <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat> <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
 <20250125225510.GJ60249@bill-the-cat> <CAFLszTj7no1azG+Us4toZA00O79sZpr3qgtoD69UpQFVNjAhoQ@mail.gmail.com>
 <7bc236dc-4cdb-4b43-a752-f9d6dcfa9498@amd.com>
In-Reply-To: <7bc236dc-4cdb-4b43-a752-f9d6dcfa9498@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:29:23 -0700
X-Gm-Features: AWEUYZlmfwsN-nzLvGTOpUbjCCsGBq4I4PjPA0r0kfprC7spBLHBbhLRIV-Dx9o
Message-ID: <CAFLszTgPa4aT_J9h9pqeTtLCVn4x2JvLWRcWRD8NaN3uoSAtyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
To: Love Kumar <love.kumar@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, Joao Marcos Costa <jmcosta944@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Patrick Rudolph <patrick.rudolph@9elements.com>, William Zhang <william.zhang@broadcom.com>, Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@nvidia.com>, Sean Anderson <sean.anderson@seco.com>, Richard Weinberger <richard@nod.at>, Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>, Roger Knecht <rknecht@pm.me>, Julien Masson <jmasson@baylibre.com>, Weizhao Ouyang <o451686892@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tim Harvey <tharvey@gateworks.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-erofs@lists.ozlabs.org, Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Love,

On Sun, 2 Feb 2025 at 23:05, Love Kumar <love.kumar@amd.com> wrote:
>
> Hi Simon,
>
> On 26/01/25 4:28 am, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
> >>> Hi Tom,
> >>>
> >>> On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
> >>>>
> >>>>> This fixture name is quite long and results in lots of verbose code.
> >>>>> We know this is U-Boot so the 'u_boot_' part is not necessary.
> >>>>>
> >>>>> But it is also a bit of a misnomer, since it provides access to all the
> >>>>> information available to tests. It is not just the console.
> >>>>>
> >>>>> It would be too confusing to use con as it would be confused with
> >>>>> config and it is probably too short.
> >>>>>
> >>>>> So shorten it to 'ubpy'.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>> [snip]
> >>>>>   102 files changed, 2591 insertions(+), 2591 deletions(-)
> >>>>
> >>>> First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> >>>> it's how we interact with the stdin/stdout of the running U-Boot. And
> >>>> indeed it provides more than that. But ubpy is too abstract and unclear,
> >>>> and looking at the diffstat, I don't know that big global rename is
> >>>> justified to save text space.
> >>>
> >>> I actually get quite confused hunting around in the fixtures so I
> >>> suspect others do too. I would like to settle on some better names.
> >>>
> >>> Yes, I don't like ubpy much, either. Your favourite AI suggests
> >>> 'fixture' or 'test_env', both I which I prefer. The only challenge is
> >>> that 'env' has various other meanings in U-Boot.
> >>
> >> Yes, until someone has a better suggestion than "ubpy", we should leave
> >> things alone. "fixture" has its own meaning within pytest and so that
> >> would also be confusing.
> >
> > Yes, ideas welcome. Arguably it is confusing that this one fixture
> > provides a gateway to all the others.
>
> I have a couple of names to suggest:
> 1) "ubintf"/"ub_interface" - As it interacts with U-Boot during testing
> and acts as the primary interface.
> 2) "ubman"/"ub_manager" - As it manages multiple things in tests, not
> only limited to console.

Thanks for the ideas. Both of those seem good to me. I'll give it a
try with the second one since it is easier to say.

Regards,
Simon
