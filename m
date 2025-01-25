Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C37A1C590
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 23:59:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgVVM4nLtz3013
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 09:59:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737845946;
	cv=none; b=WrouFISFA7HUcJxk5JrfMtb/FbnX0FccTN0IQ+DwYJRg9lLlmuZU2VKn0S0ybnse3jiU10SERhZJFtuKXDB0WSlb5lpSDJ2htZ7jlh5o65OefmhXbC8eat9qzHy7D35kVUhoaxoahqFTSgocJT/eie09LOvpdh3izsuJM8g0NAKC/F4TwyJZh3aN+XTWYTwdR2CZGgfiF9ojV0/DfqgzPFf2Y4i6NnRaHs5cvtGIvYMFpZWcC55fgGN+0V8HRjkRSdYK8fO0FBmlO3jv5yfKP74usnTMMigo/mo/jxwTaIX3mQBt9W2OWWZpywTmgrQ24c6aiFZ5o6tRh4vbZRPyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737845946; c=relaxed/relaxed;
	bh=FQDxLWZK0PSMqeIIXwAZknm+uppi6AqfqfZC2CcX9TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlcP4ZhXDkwFpHzJlcHbPMbkYcAH+rnufjQ7sVzDhOfeRh2YxyZ6KPB5OtMg2JlQxpC8v2n7E6AH+mOjXB7umxpIrea5cizfV8L/Efs/hnjwxOhWYIHmPLol1nYgjzYrjypaNSsVzXH9wTz8cC3rUGojYiClI5hzTr3+K6qt8Vm6f9qF/1FAP+Bu1BjyzgT5G5EOheMfB3c/WnTMBfH86GmUTVjveSPXiLd6qqJzCCLXzMgn8ZdWqoCYTmU0h2diQKVz5diZ8m2XYn7JRGfQi4X3AmHc9KaueTkc3n12iKL5pYwt53Lo1RGowtCegTZwoTujgvNqREDyzJ8UpK6waQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gIOmUEB2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gIOmUEB2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YgVVK0JfDz2xmS
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 09:59:05 +1100 (AEDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso5452623a12.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 14:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737845942; x=1738450742; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQDxLWZK0PSMqeIIXwAZknm+uppi6AqfqfZC2CcX9TY=;
        b=gIOmUEB2RHFFGMtpWPIDGKFxh3+WP01mQ4uANC3QCGWUEQnIce5WaeqiO+YMmOk0yJ
         7vi4xp2RSXdpoJdFoXChy6SQBfIZhzGj+E5KGK64cM5jc3Xyf06eikviSC3ROwHHe4mM
         8Mgx3pChOBI/UJxCunMJYt3V/W1sHeptjFi5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737845942; x=1738450742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQDxLWZK0PSMqeIIXwAZknm+uppi6AqfqfZC2CcX9TY=;
        b=P3jpMHWhcj/xJwcBihqCvWmk+sTLyJ7mXH/uBrXRFwdP1f2GScKrJHAXHsALdkwJV7
         7lOyciKiKJelEtgWbQHeMTrXeQjMgYBqT4FdV0qIYwTpZ383AXKS+Il5xS8JXxA/mJYF
         Drtm1zuN2Z5d3YQaqth1dxj1HrZE7jKwBgM8ixgqJm7b8nEkb73M9apgL72/DlVAv00S
         27UbCleZq4XQYmk/L9RrAuNUwhKWX0ErXFuxyNBVMjpnjLN8nTJMlxWIZcDUgxVj92zJ
         eGyIBXubhOlISoBfN4RuO/S1AZDGmNphknd4aPjzc4/IqAVLA722iNTMaQb7hMBP4slf
         wAgA==
X-Forwarded-Encrypted: i=1; AJvYcCXtleCB7net143g+9uniiaZGvJvKAZas9PAPuCPx0/mvY+0pUjYWuXqhcYz2zAMcIsfezN+n/cIc0XIOw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBWUC3P9MwR4n1XqPNgLBMQtJKOoRNIqmcxIOSRnFqlj0gOItg
	yGoIhIGhNI0QopHPrwCvQLN/6hF9t1ZnbyNSajzX68Qj/o4OkrpYzM6XtWB3aYZ+iWHvSYqpNhw
	OnF5JQaPTtGBXpxIbyH6lEPIwSJN/ERdjdXH0
X-Gm-Gg: ASbGnctGI5qILbKr+RvBDHI7dZu4QVRFnD6bMQsPFu+i0gR7UhjMkrnt58JeFDO3QVi
	rs1+93kZoDv8hxRqsibwxnxuMuIVgnkEQU4zX6Rq8+KqMOcxDS6bvfXDfQZXO3JE=
X-Google-Smtp-Source: AGHT+IEaYBTqG2tAT1zhbmQwiTblASeuVykK2jZDd82x5SHbhBgiYyAqIptOczBScj9omt56ca2d93/LWrtWPLDabP0=
X-Received: by 2002:a05:6402:520e:b0:5d1:2631:b88a with SMTP id
 4fb4d7f45d1cf-5db7d3012d1mr36824478a12.17.1737845942038; Sat, 25 Jan 2025
 14:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org> <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat> <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
 <20250125225510.GJ60249@bill-the-cat>
In-Reply-To: <20250125225510.GJ60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:58:50 -0700
X-Gm-Features: AWEUYZlrr_7C4dsjCu1hmrc4ah4Gcb6lYpTZ6nWdgbFlVzkb5cx0K8afXcNI3t8
Message-ID: <CAFLszTj7no1azG+Us4toZA00O79sZpr3qgtoD69UpQFVNjAhoQ@mail.gmail.com>
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

On Sat, 25 Jan 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
> > >
> > > > This fixture name is quite long and results in lots of verbose code.
> > > > We know this is U-Boot so the 'u_boot_' part is not necessary.
> > > >
> > > > But it is also a bit of a misnomer, since it provides access to all the
> > > > information available to tests. It is not just the console.
> > > >
> > > > It would be too confusing to use con as it would be confused with
> > > > config and it is probably too short.
> > > >
> > > > So shorten it to 'ubpy'.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > >  102 files changed, 2591 insertions(+), 2591 deletions(-)
> > >
> > > First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> > > it's how we interact with the stdin/stdout of the running U-Boot. And
> > > indeed it provides more than that. But ubpy is too abstract and unclear,
> > > and looking at the diffstat, I don't know that big global rename is
> > > justified to save text space.
> >
> > I actually get quite confused hunting around in the fixtures so I
> > suspect others do too. I would like to settle on some better names.
> >
> > Yes, I don't like ubpy much, either. Your favourite AI suggests
> > 'fixture' or 'test_env', both I which I prefer. The only challenge is
> > that 'env' has various other meanings in U-Boot.
>
> Yes, until someone has a better suggestion than "ubpy", we should leave
> things alone. "fixture" has its own meaning within pytest and so that
> would also be confusing.

Yes, ideas welcome. Arguably it is confusing that this one fixture
provides a gateway to all the others.

Regards,
Simon
