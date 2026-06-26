Return-Path: <linux-erofs+bounces-3772-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dZaYEvyRPmrTIAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3772-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 16:51:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9036CE24D
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 16:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j9UsDY68;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3772-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3772-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmzCD5BJ4z2yYf;
	Sat, 27 Jun 2026 00:51:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782485496;
	cv=pass; b=Ib6jW5nlkNj8eeWjt5iAMJBC6Fei9HDHPLC7hWvqEROPUSRUgKh5x8FXHIPUZQmLyTr8NMQaqD5UE72aiOOjkd1JZkANQtiFj2OqJR7LNk1xjw4dyfJ3i0YUlzHdGCKDa+ggGyvIHbi4xlWYNo4VOBClmTumZw01wCj5hTyYogfTkur+tuDQYdhYeej2xDLY6eifP8ovrstDHoMQub6mPinQY3zh5EhtawNSRsdPrdDPBFHjYl5qh2sQYK3Qaowi2bHJXk1l9tRWp/ZoQecdKqcSl6w/zr6A/zUUuBpWZLJHxYRfOucI7poqiwqBnzlkKFw7Zft/xa82npK4Bz0l3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782485496; c=relaxed/relaxed;
	bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omPdFc8Eqn7vdkbQ+q62mjxBEMT3/PUnLUoORc7NsrkeUmkHCV/diMox3MMmI75gfTrvLQhyXwxsS3fQHqX3/SOC1neAUuZNiTbsS45ZEX2eIhk4wuYcNh4XJq1fpdeDKSoPsonwfnN+4tlFQY79sughJQiixcvgIxw3eoLIifuxiL0vi8V0xp7xiqbrSYInJVlrDXfgLOyVWwA9+Y3gVhDs2jRqj4zi1KuvCunTtQt+0wPmEBN3Qdh0y7HFNaRphW7pFnc6mk51F5u7wqgVWM+sIyrca1uG7rryPS2wUI3N7gW8Cx8pafXUVIPSYltguVx7e9Fgdtgtls3oAZ1xjQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j9UsDY68; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=joannelkoong@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmzCB1b5cz2yYd
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Jun 2026 00:51:33 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-4627adcf4d6so717736f8f.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 07:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782485491; cv=none;
        d=google.com; s=arc-20260327;
        b=DB/tjBdvBIibUe/liFWZp0ygRxkez332CoUZnrktPWAU66xsr6pFqd1j+VFASrGs8T
         YJxI0ryY40ELKObUnCJUuH3eRbFEaZM29SGOCk3UKfL0vL3yAbUdVTacyN1h8PBn8OND
         4h8UW1GhpoAVwqeZm49j1VK8mtNiTsAU0zDpGE+uqrOpAHPUj/1pMDIKI58tofhCu3r0
         Qc3T5NREawe0VVpTVs3k0Cuke1bo5NJuMJLGAw+ZZBLan12nXKWH+CkRMCcU3J8Sx8X1
         UKy8CF/wlVCX1VR/FFsHubFmk4Np/5cfRRQrM5l6ZARz8Jc6q8chwb+t1nBuR9VgQA/a
         Cr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
        fh=Zy5dhqd3dbdMDG7MVYxw1WWyrPIKQvtl+t9sNzF40VU=;
        b=C5aqDienNtiiu9dF87wctcIbfPW/KCwYBkVZjeCDho7/49emugqmXujSrxtwTy1yYY
         bci9If6iRLtwXIUo7VbmKPkDCCa6tPJlXCFKyIJ8rTYG7AO/hGkDJkY78ZOoJtVB57Q0
         hrGbe1lbfJlSTzqJqJ6RifeCQQdt5am5StDaa7/WDKt6bp50/eqKXp++R6KJAfVeCb2E
         XxQ7I/e5ReXZV0NIyR0tk7+iAth+adKss3pWjSxxodYgmZ0Yu1TEkTPRceKARe5vISh7
         M/KkhQVGxJo9wY90f55inaZD65Myutb1M+hPZh5civ9Hbe+j5P2ULd+lgCaNvxV6JT75
         8fBg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782485491; x=1783090291; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
        b=j9UsDY68FOCfgnA444f4rDG4pvfxbFF/x1B3mJO6pT8EOAiueD64cu0F0aJsAafwK1
         TB6M0Iy9J93jwYoGWJ2cvFd4slHG+mdYN2sgInLVqpu393dp2CiQtt00qr7AVVHVHyeo
         zsFp6Tn5OlIWwAnkLdTJsqUwD7HiAGft6NPg5QGCPBTHBar6EJTbelIj7/9cOuKzVwgD
         saVPIw+A4iSRy3Xrylpi7RSBVN0eLD8r1yWXCrck+AMrHmyLUBmPWdwIRO6DJDIGqnQ9
         C884cIiAJS03qlD8+nZRtJ9c2IbrMpN1zbdDpHQ7os2tLAISBagYL+z1HgayCE4E9XMa
         cPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485491; x=1783090291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEFu/GsLUdYzJ5HEI3yfKh2VsiakBP97CsT9SHwpvI8=;
        b=lJWlsw6lQooSp2szmZLLhMgLOw8L1H41pzhIY7pldpAY1LCO1PANeF8BlKvKwg+yBY
         jMfuU1/EYb3qQkX8tvBa1ERnG6mOk1Hx6QW7PKlaJCp9aFP+i9ifZjfLyl5zmU2ZUQnM
         ShKDvDpblqlA/+dSDbx9OeUFX5aN2eOMDmqFjzqlDjNUafWUKJ/RkHlMgChuCb5JMszq
         tjjYZdndUvb3mKfMUwImUdh7qSvwdfCZNdZOxunlYgcdPwDkeeZLhIuZHnecaw3pYy7+
         c6xmoxWrvpwgyRzn70QuNzTSZbRaoCmMLVBR8iZnCwcj5qOj6UUHTASahQSue4NsZYvm
         6iKA==
X-Forwarded-Encrypted: i=1; AHgh+RoGwBIBgzL8PDlGyglhz4SahiU5S8pJq64c0kS+5qXIdZo8Iguwg/bnth4ERAe8//S0e+sJtDOIQbpCgQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxO8bU4x+mbQz4stZ7Owlx3ml3sNn4tMaYWCG7LMesxt98hq53q
	nzJvqxFI0Wqd9ywQLcMLEbCcmneIeLBfCXy2B/EYXKDu7PK1+BPza0fipA7j9LNuoFBrINTKlJq
	oVpioR8XJbXnuNNBNVNU8zeWQo3368ok=
X-Gm-Gg: AfdE7cnyiz/y66IV61V64J7A4KH76tw204I9AauOv61JtGp2I3f8uh3WIW/cEtBP5cX
	FuncV6VbFgb/1FcnuLQZuoGDhwKdS2y+az35mua+yAe3flOYaBVwx1VDk09bhxrFq4VMsbk9uq/
	DXCGblRBZNy8vGzM7ROIsTLK08EBdnPgBZbl/VXydQDJxhS2udZK5dxO2KiHzJQieQV5sM4vx97
	yC6sRczlPWjbuGOR60EcHmcV9Y7FkTLVyKiy0kWFv2hrlz7RNABrX2v6EdYYTivV4vUSJ6rZxbK
	MYBbSB4E3ESnpjj4qQRCqz9eIxHjs5C+CEYXawWapQwRgqxoBOWndspp1mMF9bo=
X-Received: by 2002:a05:6000:4b1b:b0:469:3037:37d6 with SMTP id
 ffacd0b85a97d-46dbed361c5mr11889497f8f.2.1782485490511; Fri, 26 Jun 2026
 07:51:30 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260625120803.2462291-1-hch@lst.de> <20260625120803.2462291-3-hch@lst.de>
 <20260625174758.GE6078@frogsfrogsfrogs> <CAJnrk1YFeirQ4g7qcVsda-8qPLeAtoiyW6ZBuJb2qDsGpxi-tg@mail.gmail.com>
 <20260626043319.GC8078@lst.de> <20260626061637.GA10337@lst.de>
In-Reply-To: <20260626061637.GA10337@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 26 Jun 2026 07:51:18 -0700
X-Gm-Features: AVVi8CdX3YEuehBm4GMevCFp3lRCSJHGYeePQFfRezoeBrVyeHAViWscCz8GoDk
Message-ID: <CAJnrk1aJbQ0092f=wcTu8v62rdxZ7-NxyF-1vp2e42oSEo6LBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:djwong@kernel.org,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3772-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,lst.de:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C9036CE24D

On Thu, Jun 25, 2026 at 11:16=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Fri, Jun 26, 2026 at 06:33:19AM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 25, 2026 at 11:32:40AM -0700, Joanne Koong wrote:
> > > Yes, that works. I think that's a good idea. fuse only needs
> > > submit_read logic for readahead. The change would just be:
> >
> > A nice, I'll fold that in.
>
> Btw, can I get a signoff from you for this?  It looks like splitting
> this into a separate patch actually works better.  If you have a
> preferred commit log I'd take that as well instead of mine.
>
> This is what I'm currently testing:
>
> https://git.infradead.org/?p=3Dusers/hch/misc.git;a=3Dshortlog;h=3Drefs/h=
eads/iomap-read-submit-bio

The submit_read logic is only needed for readahead. We can remove the

+       if (data.ia)
+               fuse_send_readpages(data.ia, data.file, data.nr_bytes,
+                                   data.fc->async_read);

change to fuse_read_folio().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

