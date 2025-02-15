Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D91A36B98
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 04:17:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvvHf344Wz3bmf
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 14:17:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::92e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739589468;
	cv=none; b=IMgQJOZ2MtjFygH6bz3ZfYmP7K8aENElwLgKc2u4sycfQZcFL8NZct4IENW2QISd94RAK6djHsWzaHWXRaVSCIGcoaQe+pd00MviX+2gSLcq+m5gr3Lwx01jdlW/eqlNuqnPN6TVX4CWTLk++D8SPe7ScNs3OLLpHrlt0v7u5DUjXkfHy0dQPp7WrZYD8VEK1tLUB0I/9wf7/fQM/BfbSFfUFy9+HNl/3l8XCKX7YcHC3FJrwPzXtEu1MLWXRyKcLpbd3EckYelkzvUvCLoXalnphUhGjaO9CBfGxcj/H5dGyTZ2P1sa0OiVF15xvDXmqegK2zJW8KNx4PQ+af+xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739589468; c=relaxed/relaxed;
	bh=ep1uV0XvA+u1EySwtiVo1WfO6GzO6jq/jVXel/Xzo5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgQ/eJtpVZ1QkWQS/pnmLdXWrPshhY+TK5iY5PRLd+4wmygCCzXcC94SvBaHFwLsIhsB3dHvfd0CEaNXChpSjrY6Fn3OWs8K1mmy7Vhuw/sDsq/PuL7kRjZZse/RCjfhkh3mlevist4WRAp14uoN5zDh8YPUBp/r67F6c1ByOnvb6K5pju5WH6nnkBmZlIKd5sdSxPAK4pKTc/Uj24PQFGHs3c7QOfqdZmOlqhy25zwbdukutVo7XCmNfxORFbdZskRb+jmHKpTly/8mbDtqvrw5PXkaHrXY2m5c26mioD1tGaR2zsDZQ6Rz+YU5YVXG6qC0D04VdohtOamAyW+rbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jNiZOBaq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jNiZOBaq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvvHb28kmz2xdr
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2025 14:17:46 +1100 (AEDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-866e8a51fa9so1564661241.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 19:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739589463; x=1740194263; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep1uV0XvA+u1EySwtiVo1WfO6GzO6jq/jVXel/Xzo5k=;
        b=jNiZOBaqmrfCIxhC9i6ydbDjCvsKIRK6EWu4DT8zabHWX5d009PJwREQexT34V3wl/
         tFQKY03XVfk8t+7mgkwYsfmCbe67AIJBEvD0Tm/xF11OGqurX9/Ru2DVT2ERnqZb24NS
         FIsPdj8XfYRXu9Pgy5kF+CkMY77IBpMQmugeILMNdTXBhI8XoJJEs+ZgO+FL2pHuee1W
         Wf9z03eF9UoxmOJpuMDsMWSKp8z6aRr4GzFtSX5MiHaNUJDELc6+/fE6ka2MUwIHjGeS
         7KyUsLCyQPgKnKOYWDkC3iwE7sCj4LGR9/559WgS9f96lDlscQmFZT/YBDxPYxKT1G5d
         2znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739589463; x=1740194263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep1uV0XvA+u1EySwtiVo1WfO6GzO6jq/jVXel/Xzo5k=;
        b=FVDCp/ZPAmFLc03lurM6fsgeKa/eHqG2jpTQVRzBfReEXW/Mxqz43ayAbP204YT70o
         BZqhkbzOjFpWyRBSW/W+EWhWsOXAJndy0mUtWCMrlvm0NTJTSPB27EGgNSSzzSRUn+sP
         UOssC5SxiR2IPrrECrmbcCjEVo6pseJS92uwT/rWRlN6vvXxi4MuhxLk5TrTrSbixAxQ
         o/6n83ljucYWm4gguPpDwpyVqxFlX3UCZ196I2fZYFCRXYeOrWKxfeOVglGsMaCESHh6
         bH9HNAXI0+weNVeQCXfyQ4cb8cpydqswV5gZtGS4lSPndxPRAFwgXAlBAatqpftl/uFe
         mu7w==
X-Forwarded-Encrypted: i=1; AJvYcCUV26c/iO1NwTvSqeB3ow63O38hAPTJWDIPVrVhjORizmG4ux50eXDkozTfXemEIqThcagoA5rM1eazgg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzg0E7gETKElQ0i5+9Auk0A8JPTIxx+6TQJZR4Dvdjdfc103gqb
	lHuV5KctGiKYe7FYgSvxBGDaxbqicMv+m2D1zXrG56LCxfYneGaRAE547aA7kpcKol5akjnQfyg
	qztFY5ecSlM7BTq9/z8XwvsTvai0=
X-Gm-Gg: ASbGncuWuE1nPke1gXkOBWGs6nSpUM6Mt1d4Oaec5pjm3uD8SHJ3jDmcrpXY+s7xPS3
	k6LpnoVS+ftRnQ/zqMTYjge2EPjVp3qq5zOcmgdJ++aE/k4t8V4RRe+1kKQQgnqITlOk3Ab3RRk
	ladoIJH3qjdM9RKMlhC5FGQ6aq4KpI
X-Google-Smtp-Source: AGHT+IGmij/nIE3//5YAloMHfJYlVRVhH9/e1wlUHKTIyjnds/Q9+lqWEX3nB34Po4E0fkf7/VYz4U2Zn6zAbjtSEuQ=
X-Received: by 2002:a05:6102:50a4:b0:4bb:ceeb:eaca with SMTP id
 ada2fe7eead31-4bc04dc0ad2mr7162447137.1.1739589463452; Fri, 14 Feb 2025
 19:17:43 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat> <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat> <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
In-Reply-To: <8734gjsh8t.fsf@bootlin.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Fri, 14 Feb 2025 19:17:32 -0800
X-Gm-Features: AWEUYZlFt_bIGmF42tVBXDR0Ph3awnQVuj_ERE9ZXi_WNh2uZfW2tnVP6kXGKkQ
Message-ID: <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Miquel Raynal <miquel.raynal@bootlin.com>
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
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Joao Marcos Costa <jmcosta944@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks.

Here are the CVEs assigned by MITRE:
- CVE-2025-26721: buffer overflow in the persistent storage for file creati=
on
- CVE-2025-26722: buffer overflow in SquashFS symlink resolution
- CVE-2025-26723: buffer overflow in EXT4 symlink resolution
- CVE-2025-26724: buffer overflow in CramFS symlink resolution
- CVE-2025-26724: buffer overflow in JFFS2 dirent parsing

Best regards,
           Jonathan

On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello Tom,
>
> On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
>
> > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> >> Hi Tom and the rest of the team,
> >>
> >> Please let me know about fix time, whether this is acknowledged and
> >> whether you're going to request CVE IDs for those or if I should do
> >> it.
> >> The reason is that I found similar issues in other bootloaders, so I'm
> >> trying to synchronize all of them. For what it's worth, Barebox has
> >> similar issues and are currently fixing.
> >
> > Yes, these seem valid. We don't have a CVE requesting authority so if
> > you want them, go ahead and request them. You saw Gao Xiang's response
> > for erofs, and I'm hoping one of the squashfs maintainers will chime
> > in.
>
> Either Jo=C3=A3o or me, we will have a look.
>
> Thanks,
> Miqu=C3=A8l
