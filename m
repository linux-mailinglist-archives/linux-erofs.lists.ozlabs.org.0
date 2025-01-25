Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B087A1C582
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 23:42:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgV722x6gz300g
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 09:42:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737844940;
	cv=none; b=hoNkfW7fUbcu2G0FHU2dK96q8Fsu92JZY70W31dDQPSbI0j+697D9eXPv8Zjyjq0NyO67VmeoiztStKA+M2BBZRL8qMDjFkEm7AVjSdhisWT+epWEEFnKm0jSVcOpmHJdslvkT7wJwFeABnnrKmqpL8fZq1uPPtO6fmg4i9swdJhg7uuppi1mTdoDGCp7Rfts8EslylaDgqmMXrzUFWCn6LYuBnc5LYEdggywMqgcXcm4+Ql34rKTzYNi9c7QGLFeumLXT1mvcr5dF73l0pjcgyzICiARihR9RKFkH7mQjvv31mnqp4khpgfAfpaEyCF9jSr3A9wx78pIqnDiHcFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737844940; c=relaxed/relaxed;
	bh=GxFzzrg2BQ5qQdc0TRL3eZ8awBuGyiVXkghGGlH8XjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8SUSNfpzYSQnrpgHwW5uvuzCmrR4rIukoi9EZ8958mLUssFyqPw4Ec/FoIIN+XmEx4j19SsjetU/nTKnXhHJsUS4XuJUAHJpnHiTscp+J0yBjoH2h73TVkjLFHzxXRoYIpjiRRDx5t1K10BA2+TVdKRwi3ZniRvnGzdBsR9HXk1FxxEaYKbJ8LKKSttBOBLD+HILssCdRFoVN7tTQTdbR69DHZ6aWdZub8puEOUNR3TWvPpbHfO17jOJFlBMFyDSGkbtk+fFfs+FQTuE19QmcMEQgUM/Dy+RwrLIQLKOCIK9xyJHDJXwRZyn/DrKSZCVj06NpZMpkbiL/zL3P5C0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ty4jnwWk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ty4jnwWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YgV6x69zrz2xk7
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 09:42:16 +1100 (AEDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so5185642a12.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737844932; x=1738449732; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GxFzzrg2BQ5qQdc0TRL3eZ8awBuGyiVXkghGGlH8XjE=;
        b=Ty4jnwWk2i1ZZukeXF4NDw5mL1QmTdiM5001fporeBhtuojDYqrTvW1fPMvyO5UQ6w
         MNqdKA52F4ap4qiCpE4JCex/b8l8BSLaqlVsnwRzo47mqoJ56L5TAyFvRmgT1Ip5mP1M
         czfE1S78fR4B5Atc4XE20yypmhO227DFLaShU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737844932; x=1738449732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxFzzrg2BQ5qQdc0TRL3eZ8awBuGyiVXkghGGlH8XjE=;
        b=qUmzywbFH6jrz6qw2xQ1RuODZcOG9nlR2y3qbtdaWDNv/HtiyW3d8ETehOpbtnjxqo
         VZ8VyFVtDA++l+/XQ0yyZnkwaxTvjKnQiN/ZU8Ec2xjiSkHA78pwQQIRdAX7uG6d69f1
         zI92+Tpf+Jk0O6uL1mqIxwIOh+g+SbhIoBW2tDg7SxT0SXE2UY8cvv4jHOCAXwQJFQBq
         Ga5FhuPJ5rXDIupytEZrODsqi78B1IczFWtysBbG07HUTCNPozfJ415aXcJUasvqbJ2V
         3qFThWkk+XtCQT3nmk4HfGyL2Wr8xk1CzNfs2PGIiMITOaLkYRY/9l6+cRnCL+6PWm/9
         ionw==
X-Forwarded-Encrypted: i=1; AJvYcCXBJDbKUIRHYjT8OiqLiTDTBDTyfAW41ygk5ho8wJUnNFq1s3A6KLDwkbZ3N/92IJ0OvZG+ox4Ht8I8JQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVlqPf0gkgUqlje3EsoThlm9c2ACpAefxpCJbJsEHIad/PVznl
	jAT0J2I5fBBDJvZ2bhTMTvIvzSKzPh8Wf73Z5YtBYdiW8lNiQmI9Hhq9nBfyy6V3xTOKyH1nDp0
	x5PHmo9tYPDtJHLSvZAu/M74DyXbJ4CAzEK1O
X-Gm-Gg: ASbGncs1i1F8ZgeTEefjD9eMfGHqIdhYwevRgDr+pQN8NtfbIyKBaQqHT4mEFUWFSbj
	9Tb8fzQBugNyD10+4tENKBzmqZegNw8tAcIINQFur1E13/sZJ5INmkDDgxkvAI1c=
X-Google-Smtp-Source: AGHT+IHq2b6ITll4yJBXu0vJijeOLOEJNE0zSYB4fW+9GhuBtP8venoWhQ9aCLK2BzsNCD2LBRkrw+6Gae2XDKW7/rk=
X-Received: by 2002:a05:6402:2110:b0:5da:c38:b1cf with SMTP id
 4fb4d7f45d1cf-5db7d2dc135mr32336799a12.3.1737844932216; Sat, 25 Jan 2025
 14:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org> <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
In-Reply-To: <20250125215055.GF60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:42:00 -0700
X-Gm-Features: AWEUYZnS7_IeCWffdJA7OdJPnemnLo0CmhbjmJi1FSsyWJa7yXrZlsqk5b3j6fM
Message-ID: <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
To: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, Joao Marcos Costa <jmcosta944@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Patrick Rudolph <patrick.rudolph@9elements.com>, William Zhang <william.zhang@broadcom.com>, Stephen Warren <swarren@nvidia.com>, Sean Anderson <sean.anderson@seco.com>, Richard Weinberger <richard@nod.at>, Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>, Roger Knecht <rknecht@pm.me>, Julien Masson <jmasson@baylibre.com>, Weizhao Ouyang <o451686892@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tim Harvey <tharvey@gateworks.com>, Love Kumar <love.kumar@amd.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-erofs@lists.ozlabs.org, Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tom,

On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
>
> > This fixture name is quite long and results in lots of verbose code.
> > We know this is U-Boot so the 'u_boot_' part is not necessary.
> >
> > But it is also a bit of a misnomer, since it provides access to all the
> > information available to tests. It is not just the console.
> >
> > It would be too confusing to use con as it would be confused with
> > config and it is probably too short.
> >
> > So shorten it to 'ubpy'.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> >  102 files changed, 2591 insertions(+), 2591 deletions(-)
>
> First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> it's how we interact with the stdin/stdout of the running U-Boot. And
> indeed it provides more than that. But ubpy is too abstract and unclear,
> and looking at the diffstat, I don't know that big global rename is
> justified to save text space.

I actually get quite confused hunting around in the fixtures so I
suspect others do too. I would like to settle on some better names.

Yes, I don't like ubpy much, either. Your favourite AI suggests
'fixture' or 'test_env', both I which I prefer. The only challenge is
that 'env' has various other meanings in U-Boot.

Regards,
Simon
