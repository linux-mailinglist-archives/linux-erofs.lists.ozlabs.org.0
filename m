Return-Path: <linux-erofs+bounces-3199-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBD+Ec0t0Glm4QYAu9opvQ
	(envelope-from <linux-erofs+bounces-3199-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 23:14:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFA39862C
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 23:14:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnWh90wNzz2xSF;
	Sat, 04 Apr 2026 08:14:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::634" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775250889;
	cv=pass; b=aQTtHvGEAFNF7MCQp6uh5kxq7UpW3oMYtsvgX7x4bNlrXvL+kFG3KLrUIm5qaLiaO4pzBHbHspZxaf9NdQj1s4f0Evvt8nZZev2t+QI2DlYUdvkw9hf53ve0Gea1PMIxS+/vqj4Bj6zPdksTk37CJTOOdt3BHsntes6NGREiZRgNFDV9HKw1jVfy4tReZsQyFTrvqdci7PXfY0R0LYH6g2Pdi7ofXxj4sg4cZMUvjxYO1pDcI1oWg5ausSktvrDqJGFNSuEdqzj7Qthp9pQeb6QjTWM1ip2VHCYw8JIgMzYQtav2soiYqnotDE9WIBN8G3L7cFADbbnHYKWYjKEkYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775250889; c=relaxed/relaxed;
	bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6aaaTwzm1cqLfgRJM7cArGBk7z3i9KY9geyOWxwZahJomGv/ivn5GuTAWy6AXtIAywNY1hViQbwNywgoZo29qyKnpAIjHhpKcW1l+bzC5Iov4nugw1epwu1fw7pcL5L8cokCSHWBKUsDssHNikd6vA6sgmY6QSYI1lJimt4266EJqEl/0gtg4Pza0ybepFDKdI0Rtpwe08/mp6mWmI8cCDjkmoy/tnHOk2Np5i3HYNkT7m4kFez3sLHcTaFq7seD+twsFDcVfYkoMVbY0oWh9UoGwV8gSx6j/CqX3DzKs3YV+FhvaWvoMphv1w+NFnPYJPkk2QMMzKcUI+eDyNC5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=G2VYZ6U3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=G2VYZ6U3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnWh73DQpz2xQr
	for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 08:14:46 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b256a4c6b5so13252525ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 14:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775250882; cv=none;
        d=google.com; s=arc-20240605;
        b=JzgKCoLrPbcJh03UvOpmQv74sfCnu6LZqDRWJ4EbKSCD4yNsm+WtJYg8jXRRQNLwcd
         DSkBihlzLuWivcMHNtO6VBu2L8mS6HDRPHnjtcOqSVJ0NIhqNTO+nOOZwY0aHBxsRbhR
         aBu7m2s7wRy0435O4RnOU+c5kDh0rrp+yG7ohbvBSkcIlcgvKO/JWQoV5/qgfisZuW66
         75/XlEltSyKTiqH1C5hGx53XQn/MuB50UyKF20jcsdDWlV8bkS93l2ObBx7lh47h8Wjh
         Olh3xZW1f0+MGgEBisGA+993eMJoocQX/svBPwb18PQd/MmNy0wnc6etYOQY/q1md5LB
         UZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        fh=7m2sXu0ciqBDMy+Cqb6z/DoGdjPI8ODCYa42cMDt7CE=;
        b=FazE4kiWk1i7SknH246Lbtp4p283hMjr73x68FanCgbfo1ik04WMqBxaZoGF9TwFav
         BwWaZVwZ+h1C4MwaQSjS1YvVWlAEnInIyiYwaHabEGY/urAmTVhjiWLBEbLHVM79PJeE
         yVIlabrrFqYxCl22AyHLfvQyyvpXvObgUnWBy2R4wan5MMVEFNoBz6iXloBgQgf8pvL3
         OZ3JPJKuIrGqdCerkWLEvFUHTyyZRdZkNfa4yjLETRCHdUkxYyd0tzE1mxs5V17SxYzl
         3KUUTOxyh8MV0HC3llQrn/4wdWqNbdpyxhUKKwopZo3wVrF617z8K77YWWPqJHeGTMi6
         G5LQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775250882; x=1775855682; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        b=G2VYZ6U3G7pSykihZo48N58+hq5nxE6p37TijtkJvqDjjXhi/c6xYORYtShm8838jW
         Z2DpecpS6rVLdbgYCYKVvlypbcffTCdsD5k6Gm85zI8O76cqN6aBNyfhzIQ74PHIiCGj
         gRbjRIWp2UtS9qDlq8n83GUhcwfOnjDKuaV8gLRoJPaDh0LVSu+0KmlvMTlp4DiD9kFu
         TXKaAJPHyf8gLJt3QqgY/UE/rIg/gBq4dtJtF3iAW5cJex+0O3DpI5h7luUM0jylRxv2
         AOWE4oylI1lRH8o+HNEQDAsoxHUshu4PxiAaehlEwP9qmb4HsBcw/UHE9j1NeV9KUX41
         Cq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250882; x=1775855682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        b=nES16qQ4HyQMcdPEALm8uksxzxiSjwRRHAOWfKUGmdYWTO8bkod/wCcHbqBRtjw/qW
         Lh2L8t/tRKzQXEiBwwEXk0R/rlc1hY9/2HHYktR0ZpbTZA2717m+8kXnplhcJTNZkIBX
         /M8EnWOWR+M84VYl5tSO10Fg9ub+YLNdRDpUR2UQsHHSBJApAyoO/FOAoW1N+rGfrZQ4
         xwdhb8juRr9nh20kA4R2QlwFdNKf21lMxF85iOe9C4tjQqLGMyF/cnhNJcy9xdWcQM1B
         GwV+aFrpygHXu3kyHDSKeqx7z1I74GAxsnh/Dp4gQwR4XpVaYAROLOnqz2WSjaiuYMik
         Xypg==
X-Forwarded-Encrypted: i=1; AJvYcCVz2Wnc9062GJhgJHG+VtKAsXTH2j6SsajGw0/l1enyNKaeAri/gigE2wXl0aAJ1MAun90nrL+nsvLzxw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfcDrPsGkbp3DgVxdT8y+W1BL43L7exzINrUmOo83m0qQ3+rBk
	7lQrRSLNsBfalgdo1fJbifDnb6Eq8nDNBT1a4k+m4CdRFDHR9HMntDVFdXWMXwKS1q8BdKbglaj
	XZA6W7PvMBEjZ73otnLnFaP+CfUoE4raYyM5N6YPQ
X-Gm-Gg: AeBDiese3jPINouDkY84lL1ZQ/nbb6fwHFVoP8XH+t2J91Z7aaUAjy9miE3N5yJjqrC
	1Tgy2hQTPj7xeg3d8qcwPz8uQHyEQ+Adl0Fpsy7/MwIw2rooiHALq4uvQbX5XD8UfzPlRCYvWMR
	RHPUIp7vM+B2/YFE6QohdwE7dIKcVs/jeDu2j8Nav3i1tS6VIWJbhnHyxRayIo7vGlnjbO8HbW9
	D8jTYuUeZAj99UK6Nxr6q0h9TNvDogazPUe8rPbCgeIqijl3YvKh7Q6oBAcSjzuXYmN8CaShR/+
	FaReceI=
X-Received: by 2002:a17:903:2ed0:b0:2b2:5091:1c26 with SMTP id
 d9443c01a7336-2b2816d8626mr47571725ad.22.1775250882586; Fri, 03 Apr 2026
 14:14:42 -0700 (PDT)
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
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-7-paul@paul-moore.com>
 <CAOQ4uxgd1wo9U32L_sQLfswY93LRp4yPzkJvKtj=wDKi8h13gg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgd1wo9U32L_sQLfswY93LRp4yPzkJvKtj=wDKi8h13gg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Apr 2026 17:14:30 -0400
X-Gm-Features: AQROBzBl5cCyhzn_4rsiKSOgf99yuNguIB3BwaumzWCCJnTdkerDXkp2yfIst38
Message-ID: <CAHC9VhTyFJottNM-Reg8dGbU4T_gAG63oOQjwrOY0x=2sCLR4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3199-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 8FEFA39862C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 2:12=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
> On Fri, Apr 3, 2026 at 5:09=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created:
> >
> >  security_backing_file_alloc()
> >  security_backing_file_free()
> >  security_mmap_backing_file()
> >
> > The first two hooks are to manage the lifecycle of the LSM security blo=
b
> > in the backing_file struct, while the third provides a new mmap() acces=
s
> > control point for the underlying backing file.  It is also expected tha=
t
> > LSMs will likely want to update their security_file_mprotect() callback
> > to address issues with their mprotect() controls, but that does not
> > require a change to the security_file_mprotect() LSM hook.
> >
> > There are a three other small changes to support these new LSM hooks:
> > * Pass the user file associated with a backing file down to
> > alloc_empty_backing_file() so it can be included in the
> > security_backing_file_alloc() hook.
> > * Add getter and setter functions for the backing_file struct LSM blob
> > as the backing_file struct remains private to fs/file_table.c.
> > * Constify the file struct field in the LSM common_audit_data struct to
> > better support LSMs that need to pass a const file struct pointer into
> > the common LSM audit code.
> >
> > Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> > and supplying a fixup.
> >
> > Cc: stable@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-erofs@lists.ozlabs.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> That looks nicer.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks,
> Amir.

Thanks for refreshing your review.  Since we are at the end of -rc6,
it probably doesn't make much sense to put this in lsm/stable-7.0; I'm
going to merge this into lsm/dev which should give us at least one
week in linux-next before the v7.1 merge window opens.  If others want
to add their ACKs/Reviewed-by during that time, I'll update the
branch.

--=20
paul-moore.com

