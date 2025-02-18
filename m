Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43BA3AC77
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2025 00:24:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyFwS4b3bz30Qk
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2025 10:24:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739921063;
	cv=none; b=POlDgqFuPpz+8KU2cVvM2AtWQSqfEN+OHWsR1u1zZwZuLW6s2Ju86oqcBQqBtMXxW534xl97qz1M/0Hrv3sZNQM4Tm8o2YP2BwoiQg5L0YqwwUMiIEr7rRXL7jKEazE1iVhaasoeTiCNQA4VqGTtxOvCHYTGKcpDiYCWgFkC6TRdfobS7+IsCHPiomcMwjR7jhaqI2disWlhjYH+5orySw7AprxgzNKW3XEsi8wgxaM9idYFYlCdbbBdgc07Wgp0R6gy66+w7vEBysdlE2azWXAPRFWQma0XTZV3KZ74uVFkUP6sdVAzWrMzxx+Ps3YkQSMC52YkusAw4tF4qSgouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739921063; c=relaxed/relaxed;
	bh=BUcIIT81Q9EqNr26lF9JwrIC3STe9TheYmssfKk+hR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyftLaYoxlmyHjJ5Vi5aRVfVjyb8nEwR1vAKOFNQJCo0fhHTnWnrpiYzmPyQCf5NJ41itO1/xDo+QogxudI2c3FFV3eIxs+oaEaWCGWjiT4BvKtcssTHFiVC/VdcA1GyK2gqNB+Huhouvdb1M0Q/pvgFfot+GG7uJQuF778gwlt/GOKHWWfIyq6xiSAGwSUQQTuXXY8q8gxBtA50jD9Z10o/AejchkpzpP8DScqUmEWRgMr/hubZBFF5suejTLMIy9kiPCebO8wVAc01fKCsflueQJslTlDJKwhZerIT4uc1P1LXMqArnw+CWLh0NiAldij6alHIk0nS2MuWHHYd4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V8T7Yzoh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V8T7Yzoh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyFwQ2WLFz2xHT
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2025 10:24:21 +1100 (AEDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4be5033a2cbso1409825137.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 15:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739921059; x=1740525859; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUcIIT81Q9EqNr26lF9JwrIC3STe9TheYmssfKk+hR8=;
        b=V8T7YzohiOABRkzxgt4oFWhy2Qj1Kpiy5hIEL2rVM3CqPDNU6F10SPp/0GQFnx2RYX
         s5fg5kxVjJ3NPsPaYoARIWMJSiXgWTz+cbZnVlwZczFR5oTqxdrjktv5k+rg/D9CcSuj
         Y/BRK7a/YO613I4NrgdPmltKRdHZV8kscsOm27RR4McnKX/V9Hf5wn34awwXp6qHru5S
         7vcsujwkPufShyE7Xv8Ecl7QHpdxl9Ly8a3U2CETt4k+khxm427fNF9GZFDznKVoEeM6
         sB23NwFW8f9PkLKS9cSfH7Yw8tHLoeWh7DRHYuVJKs4pLnXpIsLaw0ztfwGwtmvdx0N/
         NoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739921059; x=1740525859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUcIIT81Q9EqNr26lF9JwrIC3STe9TheYmssfKk+hR8=;
        b=j4wNhmeOWer2YzvQ8KlTkvAXFo5w24kzmAVwccZ92+SW7Q+kPFpsRMuouePaWcAWjB
         8x93tJ/PJQv5j6Na3IfEiNfWbn4jleOrDnr/EmXQUSEMx/il1Y1SwhRmIuHCHf+lkWdw
         lHfR+a8v91nyjQRFhuofhfI5gqWmzeeXp8TM0/1Mf/cXX11wS8NWfrxraLDG+usq/NoN
         6IGK3uk4lK0ChfVb7b396qlTIioi0WrPlnnlWRVsr5XFBLYTpxoUC05G62KXODA6URsd
         PL2ivjz/zdAYkxRP4H++vs5T13yw5nV0s/euWpWDpWMik+LPpE7L9NjK4qsY2I+1H/u9
         R7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVrZECrjGtuV+pesQP26oOoZFs4FIsBPrt6pcPwumI4BIvCoSwQmxocq8qmjyuZCi+cHkwnCuqhzKebxQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzbr/IdZRuq2uJooXxns4km3KYcOyCoBSWK3azuDJjH50AelHql
	vdZ7RjuBcbvw+Dkwr5E2Twh2FXOCDSn8dS8iz84vkUkXmfKFXBHSUAv1mlKQh2lA2W7yhFSBIHR
	N1W6hLsX7Y7bf/CI5Bj+jQ7NeRDI=
X-Gm-Gg: ASbGncur7n9alsaV8hVQ9ZWU9vy+UD/0r1rilrlz1yEQ8z6Sr+UqaplN6Dxv8oKFviN
	C+giVP8rWVhUT0+Pw4Xsdm/jLCQ17Hl0hnuG21gc96aW1vILhEoCmTu1C17WONDLsbQGN79pC7+
	kUJgyTX/qiH4izoo6D4WSG9EasNaId
X-Google-Smtp-Source: AGHT+IHtYQsXFov1L2TbI+t5HjiY6Kp0e2zRm46BC+bquxNfvBXEnqKtGzza1mKZAFDkECZ4y9Qyf9dOcqVOTrkoc68=
X-Received: by 2002:a05:6102:5e91:b0:4bc:ad3:a697 with SMTP id
 ada2fe7eead31-4bd3febe5bbmr9960033137.23.1739921058993; Tue, 18 Feb 2025
 15:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com> <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
In-Reply-To: <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 18 Feb 2025 15:24:08 -0800
X-Gm-Features: AWEUYZmCHIgTo2Wf9BUm-soMSznhzMKrrldhFQufQNAq9KyqWClXGI9cvAOoA3c
Message-ID: <CABMsoEF3xcbpFXMAYW-ZzQUfZp3zVf8FsKmtxQ7wfVxu3zjOcA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/erofs: fix an integer overflow in symlink resolution
To: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

That's great! Thank you for your work!

Any expected fixes on the other issues I raised Tom?
I'm asking specifically because GRUB2 maintainers are working on
solving very similar issues in their repository for SquashFS (being
rolled out right now).
It'd be best to solve ASAP as people might realize the similarities
between GRUB2 and U-boot in that module.

Best regards,
           Jonathan

On Tue, Feb 18, 2025 at 11:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, 13 Feb 2025 19:28:47 +0800, Gao Xiang wrote:
>
> > See the original report [1], otherwise len + 1 will be overflowed.
> >
> > Note that EROFS archive can record arbitary symlink sizes in principle,
> > so we don't assume a short number like 4096.
> >
> > [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> --
> Tom
>
>
