Return-Path: <linux-erofs+bounces-2734-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFaWI3e9t2mpUgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2734-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:21:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BF29614D
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:21:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ7Ml5CD1z2xpn;
	Mon, 16 Mar 2026 19:21:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773649267;
	cv=pass; b=M3qzXUaOp090plJWyn1Hj/4mpON521AniDTYUGqtwaKGqzfT7TnEBtNFFhCl0BL0/mHJVZJLmL1/utqxo0p0GqXi4DHapOZi6HpPOm0qtA9Mqo+tYN0GpxMfQoW8ycAIaYruBk0vybg/zXFYrFMiHLSgYkR7O6P3l1JBC7SVOcCNL0HRowGnj15itASflU3GKpH18wVbdMDpXkHSXtUa+1oCDeua5ES8viu2RPsRTnwdYuqSzmXUuv5SoOEstJscu470VAF3h0usvxAN80LEnYbhvVq2vAzU+SgOd84kcG9FJtOgEmZ+3xwJCclSXaa4ux7wGrpFQ4H7UR7h2hLMsw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773649267; c=relaxed/relaxed;
	bh=OC5K7IGHE+lt6i8IoiuInECxMPPTGhBju6O1aUS/RJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSqE2nPtYFF6L8RjuZTQQ+mzTkoqpZcn0lj/gf7XHhScQdZuLFvV/hJJNSkA2H5Epa8HjRyix9FQf7W6uxDg/hbssbSVcjLz5ByvXOD/kf9UJT0NrLf8fvozRbpFcWQOeiqQTjZC4RAss5KMFwCQ6EhSlTMCrEWEh9TMxVrU6jz203iHI47zqDfmlcnOe2ZQ/vzkyfKKCbd7iJDGbHmiTg35RyQsQ9F66r6iddyJ2L85Q7Y2N3DfAeSgNB3r+f5EwPQmoWSUf4MIXTjWmDyIowlt/WdJERoFTRv8QnzQwYWhGZup8lQTmmU/XnPEcwnyTX6vWREcnRcz4Beu4g41Ew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VppMNZ3w; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VppMNZ3w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7Mk2mgtz2xln
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 19:21:05 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-899f50ab3f2so8413846d6.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773649263; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6OQosKGvJ4BhmavMsBeov/5evZ7NUbufTZC41lBdrtQkKiCE3y48ZdFIXAGP2pdyz
         pZgsytPlf2rNCp6jGFSAmJfRRBLpVf1uoGanq7HWKGAsP2JMUutkDGkrfSnio55WQBpF
         GtV8i3RGvIsFpNHn5O6pofBYWSDePiWH54/v9TdAPf3SbXlGYzlf7UDI/Ecs7PgI3YVW
         zUf1vmtdm77aEtAZugbFkkdkHeDneUVxParLxn90tImNh88P3VVUXHXb5YKOLcU7Xjgr
         nDhDT9F3mIW21tj2UUpt3eOayBo9HBIyZG3dGzJTx9sCceSenk52WoNq5qHi9LiVZwfS
         XD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OC5K7IGHE+lt6i8IoiuInECxMPPTGhBju6O1aUS/RJQ=;
        fh=+B5NJMHgZVlSETmvknNIc/yWRJuXFX3qfkrcJIg5vdE=;
        b=iu2ufhWqXkEXgofQIntLWFylcD3ku8TQKuDFZXLKDAy8AC5NmBuSGRZOHXbNB/un36
         +/VnzzMVKlUszwMq62sUlk2dj+IAfab3qG1QveRaRWT7MoCxFlS2pUxm6vru6wjl1rHv
         IgtgapILr4Hd055srlFSzX4t1I+zrhv02hYNrnWXRerLKZPKutggpS+Sb1RJFJacKl6L
         IgNvax02TB6aK0wUX4bsjfhd7OsnXbO4BFGhSZveww205FM1cj7vg+NHW0Oxv3Kj4eNu
         o0EtMNLtNJUWSbqgoahJtLmgbXmqD/v3OofW0+7whX3gZaFh2yEnU7GMoyyqRKFlJV8A
         z0hg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773649263; x=1774254063; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OC5K7IGHE+lt6i8IoiuInECxMPPTGhBju6O1aUS/RJQ=;
        b=VppMNZ3wv7/Eescm7EzedCX7fWkJsxWJDba3xwfdadThOKGVuK53n/gU/HC9mJeOfp
         nytftSgF30W/TvThszKtMEpl34c3RmBSbTLtDLYoSUWjcCltSWH9FjLoMmszCHNWbCPP
         pVPp0j5l5Mm4TgUtSD9Xi6ixvXInjFr4VfngIfmGzsT7pRi1637Q9wx4Cd0fyqbkSAPM
         YJbxEoveQazHACAhlehWgTiz8DiH3UpwzCJQaY/o63WnSDiZIpcQ+0CTBeySp3NcNkbI
         YcvZIoegBPk0OTakZ6LMK67ja3rooMfsmZYFG7Kyi1JxxpTbgA879XV3owCwkIWxm90q
         758w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773649263; x=1774254063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC5K7IGHE+lt6i8IoiuInECxMPPTGhBju6O1aUS/RJQ=;
        b=b0YXy7I62aV+CQ0tUqYXdkwqKY62GuLcBMW2NzLls7WeQmOn3sajTyEQCRzFES3r7e
         i/Rrf8FjJBU4OZ/xIEsUWEiGauqR3QDGifFeovf19yngDXm7/zsB89ZJUDBdYUeTxIGi
         qOSWMUnRCftvbx7qJMnjKLWBoWqrqbWXNhzN9Sxt0Lz9FD+jm3ou4M6/TPTpcHcJKhAy
         CvRhmgcc5kSJf6Gbl+2pXpnIA4tSSojK07W0X2PJLs8ze1qBusdiMdFq3APOTak4dtIr
         nPxtEOoXe58qbOKLaDG8XHux7nWCJKwnoAzLrtBCqaBQzfZVm5FPSvcugu7j6xfe9CXb
         /++g==
X-Gm-Message-State: AOJu0YyG/xAw9qUEwHv3jZHmji1Gm2ncVFXsumKU55Zvqh0MGJpLOpEB
	Gzmid8dV0Ca+IvHC4vGRMOILLHy1RSEwDvwSr1ELiZxA2eHUFc0MqBSSqvkZKbqRsBbcTr9IMVw
	TiAY4ODn/mexEWBCl55qHuWfHJJG8DvxGLZwJGns=
X-Gm-Gg: ATEYQzxu0pF7xfGu2NOi8bb6zsZOjuBxsGorD8zDxHLtuL3YxfOzgNVvr1RIJdkRTY8
	QxszermBiTNxEAyz+oD/ObSrN2tu03hW0KoNqaHhWwdns+mg6Mr+SuQQCCNBF4prQAS1k0T8gGc
	vNrrZ8AGmmotrsRyt9fDU8n/2NscuF9x24BftkIf85wQ97KwuZYESdZj0y+JBGLMi3UY6H1bs22
	zQAGTyElBw5KUsZVScX9g9d/fuWquHFVlJKXxH5L3Ztd0MQzHtaNf2HEl19CnS9KvzbxaWIO4oW
	Wx3xgH8KObJqbLL1VZvJzuynKvILMPMxwy6TgSQTKY8+ijzKZM+P1DZ+z+PLXgY3R2umVQ==
X-Received: by 2002:a05:6214:6014:b0:89c:58fd:41 with SMTP id
 6a1803df08f44-89c58fd062bmr3399066d6.8.1773649262996; Mon, 16 Mar 2026
 01:21:02 -0700 (PDT)
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
References: <20260316075831.35495-1-singhutkal015@gmail.com>
 <20260316075831.35495-3-singhutkal015@gmail.com> <22c5ced3-3fa9-42ba-8255-ac93e411d628@linux.alibaba.com>
In-Reply-To: <22c5ced3-3fa9-42ba-8255-ac93e411d628@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 16 Mar 2026 13:50:55 +0530
X-Gm-Features: AaiRm52dDJEBoTwesC7RysNQ7xtOYPJmHk8MmqCKjxFXB3GvCqIcXF37mG6bsYc
Message-ID: <CAGSu4WN072zUM1HVq+au3oDwLdMzwynyhYWefWM=W091OsVfCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] erofs-utils: lib/tar: reject negative size= value
 in PAX header
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@foxmail.com
Content-Type: multipart/alternative; boundary="00000000000046f059064d1fe672"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2734-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,foxmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3D6BF29614D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000046f059064d1fe672
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2026/3/16, Gao Xiang wrote:
> please just follow the format like this, you need to compress it
> to avoid too long message

Thank you for the guidance. Here is the compressed reproducer:

Reproducible image (base64-encoded gzipped blob):
H4sIAKe8t2kC/9PTD0is8EhNTEktKtYvSS0uYaA+MAACMxMTMA0E6LSBgaExgg0WNzcHCilUMIw=
C
WgNDY4XizKpUW11DrtHAGAWjYBSMghEEAM45fzIACAAA

Thanks,
Utkal Singh

On Mon, 16 Mar 2026 at 13:33, Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:

>
>
> On 2026/3/16 15:58, Utkal Singh wrote:
> > The PAX extended header size=3D field is parsed into a signed long
> > long but no check is made for negative values before assigning to
> > eh->st.st_size. A crafted PAX header with size=3D-1 passes the
> > existing format check, resulting in a negative file size that can
> > cause incorrect memory allocation and heap corruption in subsequent
> > read or seek operations.
> >
> > Add an explicit check to reject negative size=3D values with -EINVAL.
> >
> > Reproducer (base64-encoded minimal crafted tar):
> >    echo
> "Li9QYXhIZWFkZXJzL3Rlc3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA2NjYAMDA=
wMDAwMAAwMDAwMDAwADAwMDAwMDAwMDEzADAwMDAwMDAwMDAwADAxMTA3NgAgeAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3RhciAgAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAxMyBzaXplPS0xCgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=3D"
> | base64 -d > crafted-negative-size.tar
> >    mkfs.erofs --tar=3Df out.img < crafted-negative-size.tar
>
> please just follow the format like this, you need to compress it
> to avoid too long message:
>
> commit ab858f291a1a
> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date:   Wed Sep 24 15:17:46 2025 +0800
>
>      erofs-utils: dump: avoid SIGSEGV when time cannot be represented
>
>      Just show the raw time in seconds since the UNIX epoch instead.
>
>      Reproducible image (base64-encoded gzipped blob):
>
>  H4sICACa02gAA3JlcHJvAGNgGAWjYBSMVPDo4dcHvU4WITpANg+DCgM7VPwFM0INE5L6OzNL
>
>  tafaus7ZdHvpkTy+2l3o5rGjCxAAIGsOODIzlDD8/v//P0gEQsKACphkZAG5QgUqFgpka0LZ
>
>  4QyMDKpQdgJQPAzKTgWKR0LZWUjsfE4oIydVLzk/JyUtMyfVAEQYgggjEGGMbD/QYoa3jYwM
>
>  KUCaA+y6//8ZkeSLK6uyE3NyUovQGaz/YfZgSJHKwBd+YPc5MjHYQvkg94HiK6KjuRHE14OK
>
>  GyCFnyGQbQhlGwPDJhjKtgDGnp6eHiJIkPwvxYIwHylpoPmfiQq+RWcwk69dUJcG7hllDHUG
>
>  I7oIKEPDRcTe7jqNqesp5bYzYs0ydGCACy4gwJC6xEWZyWxQH2FVgyifQKW3OlL5xMLAAi8/
>
>  9EtyC/SBGnQzcxPTU9NT84yMjM0MTAwMTI30wQURhMQo9/7Ayz8OcPnEhWQ+K46yko2RjaEi
>
>  saSkyLCCgQFIwvlGEBKpxA3elv8GrIcJXP4xMWgoQ8wARSLY2zgqOkYoZgLTIJYGM3aVo2AU
>      jIJRMLAAABdVKPsAEAAA
>
>
> Thanks,
> Gao Xiang
>

--00000000000046f059064d1fe672
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 2026/3/16, Gao Xiang wrote:<br>&gt; please just follow =
the format like this, you need to compress it<br>&gt; to avoid too long mes=
sage<br><br>Thank you for the guidance. Here is the compressed reproducer:<=
br><br>Reproducible image (base64-encoded gzipped blob):<br>H4sIAKe8t2kC/9P=
TD0is8EhNTEktKtYvSS0uYaA+MAACMxMTMA0E6LSBgaExgg0WNzcHCilUMIwC<br>WgNDY4XizK=
pUW11DrtHAGAWjYBSMghEEAM45fzIACAAA<br><br>Thanks,<br>Utkal Singh</div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Mon, 16 Mar 2026 at 13:33, Gao Xiang &lt;<a href=3D"mailto:hs=
iangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026/3/16 15:58, Utkal Singh wrote:<br>
&gt; The PAX extended header size=3D field is parsed into a signed long<br>
&gt; long but no check is made for negative values before assigning to<br>
&gt; eh-&gt;st.st_size. A crafted PAX header with size=3D-1 passes the<br>
&gt; existing format check, resulting in a negative file size that can<br>
&gt; cause incorrect memory allocation and heap corruption in subsequent<br=
>
&gt; read or seek operations.<br>
&gt; <br>
&gt; Add an explicit check to reject negative size=3D values with -EINVAL.<=
br>
&gt; <br>
&gt; Reproducer (base64-encoded minimal crafted tar):<br>
&gt;=C2=A0 =C2=A0 echo &quot;Li9QYXhIZWFkZXJzL3Rlc3QAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAADAwMDA2NjYAMDAwMDAwMAAwMDAwMDAwADAwMDAwMDAwMDEzADAwMDAwMDAwMDAw=
ADAxMTA3NgAgeAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3=
RhciAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxMyBzaXplPS0xCgAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=3D&quot; | bas=
e64 -d &gt; crafted-negative-size.tar<br>
&gt;=C2=A0 =C2=A0 mkfs.erofs --tar=3Df out.img &lt; crafted-negative-size.t=
ar<br>
<br>
please just follow the format like this, you need to compress it<br>
to avoid too long message:<br>
<br>
commit ab858f291a1a<br>
Author: Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com" target=
=3D"_blank">hsiangkao@linux.alibaba.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Sep 24 15:17:46 2025 +0800<br>
<br>
=C2=A0 =C2=A0 =C2=A0erofs-utils: dump: avoid SIGSEGV when time cannot be re=
presented<br>
<br>
=C2=A0 =C2=A0 =C2=A0Just show the raw time in seconds since the UNIX epoch =
instead.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Reproducible image (base64-encoded gzipped blob):<br>
=C2=A0 =C2=A0 =C2=A0H4sICACa02gAA3JlcHJvAGNgGAWjYBSMVPDo4dcHvU4WITpANg+DCgM=
7VPwFM0INE5L6OzNL<br>
=C2=A0 =C2=A0 =C2=A0tafaus7ZdHvpkTy+2l3o5rGjCxAAIGsOODIzlDD8/v//P0gEQsKACph=
kZAG5QgUqFgpka0LZ<br>
=C2=A0 =C2=A0 =C2=A04QyMDKpQdgJQPAzKTgWKR0LZWUjsfE4oIydVLzk/JyUtMyfVAEQYggg=
jEGGMbD/QYoa3jYwM<br>
=C2=A0 =C2=A0 =C2=A0KUCaA+y6//8ZkeSLK6uyE3NyUovQGaz/YfZgSJHKwBd+YPc5MjHYQvk=
g94HiK6KjuRHE14OK<br>
=C2=A0 =C2=A0 =C2=A0GyCFnyGQbQhlGwPDJhjKtgDGnp6eHiJIkPwvxYIwHylpoPmfiQq+RWc=
wk69dUJcG7hllDHUG<br>
=C2=A0 =C2=A0 =C2=A0I7oIKEPDRcTe7jqNqesp5bYzYs0ydGCACy4gwJC6xEWZyWxQH2FVgyi=
fQKW3OlL5xMLAAi8/<br>
=C2=A0 =C2=A0 =C2=A09EtyC/SBGnQzcxPTU9NT84yMjM0MTAwMTI30wQURhMQo9/7Ayz8OcPn=
EhWQ+K46yko2RjaEi<br>
=C2=A0 =C2=A0 =C2=A0saSkyLCCgQFIwvlGEBKpxA3elv8GrIcJXP4xMWgoQ8wARSLY2zgqOkY=
oZgLTIJYGM3aVo2AU<br>
=C2=A0 =C2=A0 =C2=A0jIJRMLAAABdVKPsAEAAA<br>
<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div>

--00000000000046f059064d1fe672--

