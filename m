Return-Path: <linux-erofs+bounces-2825-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIgHNN1WumnFUgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2825-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 08:40:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 952EE2B7190
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 08:40:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbLMX56Vqz2xYk;
	Wed, 18 Mar 2026 18:40:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f36" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773819608;
	cv=pass; b=OYTlPsk+alGjPe1vjAdRK33lw3cK9gSVqd28UfKY3yT6y5xImRPYk3nkjZW+s/a96WtGlV+kpwZVMlzjcPtTca14pjVoIKNitQgj3bNtnv+0yE2w3nj2eWlS4ekGTlFEVnoUvL++97yR97KIhb3vKQAfZwwIk6Ei03kuLxTGP1GwDgibsL1/O0hefNV2NXIeDSZxxIFzRVHqkwYMCcmV4c9W1CiUeBpLewPl22IyLjSs0P3TGUKVGe+4NPZjW5ir4neuaKG6vpQums4SVPD27BO2SaiGm4Jo2JXGXH2w6crQdubBrr/Y5e6+G+EJsaflFrq/Z21FJMDsqFVrixA95w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773819608; c=relaxed/relaxed;
	bh=gmBcC/JdHyFS1UAFnPhm4BjTPXUbQ1NVV8QlDJ+nXhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1zymKaJDCuc1IpAZ2oZJLHcduJcfzi1PNuel8PCJIW74OANjYpLe/9yRR6DU+lUa1y1Yn6NM2fRS17FOKhF42CtYviZqSg6hHMAAGHLSFS0wlM36xFvQ15V5PntWsOeaDNQcAF+llHtlvAQcqfZOlwWzLSqKJkqDd4aGqh2upXzbtdAQO1u24RWFKgCXV8IuwMpDd7+l6uzzhzQyYucFcCwfuI3DE/xcN3WJUlIayujHqd3bWQ+/VxaBIai6/lm0DZ/AEcGo2xVoB1wXudwK1KnJTXe/nPfDzYthtnWBr/XkmRJn/VTPWiQT3EzppOefqEukFM1CWRJ3gaPLDk07g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MKkfuHx/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MKkfuHx/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbLMV2kg4z2xQr
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 18:40:05 +1100 (AEDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-899ffee2b55so5418116d6.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 00:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773819602; cv=none;
        d=google.com; s=arc-20240605;
        b=PxjrHi3x5xKnC8jzmEhhfH+vzs3bZQfLsEn9Iose8ftRzeyb2EKBYg5RIPqVhWoVFx
         H/BobI5F8b2QHIonkGkoNH2yys8t+8yJ8ivCimCu4/DpApswd+cyCbMfDkQDL1AWd2C3
         5NlehSW1xYCSA98Dfw2Nlj+ZIKoaLcVzAf5+gmxvCtcqDRjE9coYc+vF090tDaJMPuPO
         eM6QIPcNKVPXlnO6IUstpbpzeDT8/TEXAE/VKsVUJowYjNZ8+7cQrLWtxQNXGKfuvw79
         xtBbk+XNSF1u+iGU/a6pBUGnGdc4GNqA+NKFUx7fvNnUFGhMKkPH+PepxIrXxrw4A4yk
         zrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gmBcC/JdHyFS1UAFnPhm4BjTPXUbQ1NVV8QlDJ+nXhM=;
        fh=F85tW80smOvLYnYcGRymeBe15Ok6YIx/fHXGdsKB1QI=;
        b=I8PS9I3ZLMZZnfwNbVLnLtJsnzPMq7qxO3eMJwfR1rFFP3hU355ew6K7VI/FPfhmv2
         v/CSbcHkv+Id0dEqPA/ATzLDEl94W32ScZaocftrEtjUi4B83LtNeSg6OdPSdym8uBhX
         LJAfCTgf2kR142pgAhNvA6C2gjMuGlQ7CvvRD/IjpKcY4ikHJxYXNH4WMLv8vJ4TqRkg
         CEJgIGgIHbj0D/n8H7UKlQTA6HZxyZ0oPzZqnsOchlA4WRyN6bKdcY3PCOZWdhtyFSGW
         wUAGcfhi8FFkdWpblR7NdMtGY6jHDe0Os745JLSK6JwrTZNAp/RG1XOxcfTGAQJH5vrE
         dIbw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773819602; x=1774424402; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gmBcC/JdHyFS1UAFnPhm4BjTPXUbQ1NVV8QlDJ+nXhM=;
        b=MKkfuHx/EJT3TP7JWnrnJvdI2+3rfOcjXyNH0rkkPS8vrXciwTsQaaaYGfnrQqv/0c
         qVqQZCz/gDT7jOzta6yZQplsrXGpFi3b550QJ2r7EpGlHEWjMqTCV2ofMOTlaN5IQOy1
         kCSlfSWYdU1GIgW21EheI3+uqk3cW3VahItPGwa7ElmKu6hbfUCBHWyXdX0fCSvPDlpr
         KBZ6Coz5BUfMMDAiraZFE+pUYYurfa2cRUNHtTBZjF2PCouB1be4iChPWlOvd4aPFpXg
         tvdZStolzR7+xiVei2u1VSQyqAcoJLfN1mkVDjdgpWESMAFwi8bGplu6YE1K3I6sodQQ
         +tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773819602; x=1774424402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmBcC/JdHyFS1UAFnPhm4BjTPXUbQ1NVV8QlDJ+nXhM=;
        b=dY1h6eJ/Dd71Oj4Vht+AcJSkgdh/5bPwmdIJ58ZPizjRtEx/IhPZMjmsO+KBiWCjKd
         jo1aVjPbH3tw9ndqZTiiA7ZYIC3Q+doD340azneS+JltSmkkfJk30wBw6G0adIH7fTlY
         n5lCScgKpZdk3b9JvNhIHLWaUtGr0Lg4R2EOodQzMn1UHFs39OJvFpxnrgANB61bh4Zt
         lGQ3KMRICjfqlad3F0Fp7yVgOnbkRYg3Yo12Wv7qZo7qVR3irfD9kDVm5DXdSdlcRBez
         2CymstJWHtSZAm+r9UQIS79Hp0xlDgKA33PaFXPiCwCbQWM5rMTIju+AAIRMFjB32jel
         6DgQ==
X-Gm-Message-State: AOJu0YzMMCpR8umlu8KugCAmnNHohwUg9tKidak3ZvXeYCuM+0p6tb7l
	FjxRt8M0h1hnO5KqbHKc/cHP2dl5Pgg9up47N3DtotUT65L9IQZyDBVpUPbc1sU8uQuXx85Qrqc
	KHfIf1DoW3e6Lf8tmo6Eg21shA1d22p8=
X-Gm-Gg: ATEYQzwTgRdFFnGH6bNBEWwNFnNj2QQGu4jteKN7d0AX0GBEt/lVaSpoao10hvImLce
	6S0prchrQ8tF28AVpW5C0XfWHwykY5KLHacz67mgEjIdKIIBxxAkCDTupPUlzjILXJDT9YtCvSR
	k/T02/m9lE4ktGF2sth2AZa6JllIn4LSqkUA5OhPw+xzyLmpemoaNOtOs/QOEcVzXQCctKGns+t
	PajQ0Yaw7r+C2/SfvpT8y0mIdZ/BVi7jhJzJy1q2HvnN2TGhnDVJMAObZhH/Ih4lqZzL8NHMQTu
	E7sLcO/RUjZlNdxHwv1gmyFeMxaMCXq7DSLuehiew3Uy2GxghpqElsPbAx6NxGyWJKv4
X-Received: by 2002:ad4:5c65:0:b0:89a:4fd5:6998 with SMTP id
 6a1803df08f44-89c6b48b050mr25587896d6.1.1773819602321; Wed, 18 Mar 2026
 00:40:02 -0700 (PDT)
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
References: <20260317152439.5738-1-singhutkal015@gmail.com> <7ac4676c-f68b-4cfd-9356-0f26f8215aed@kernel.org>
In-Reply-To: <7ac4676c-f68b-4cfd-9356-0f26f8215aed@kernel.org>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Wed, 18 Mar 2026 13:09:56 +0530
X-Gm-Features: AaiRm510xRVmz7Qv-xSbD1Slbmj_zimOT7lRfnmr_6L5JzqDnP1NtmTiJIMhEUU
Message-ID: <CAGSu4WMGStFw7DzePCDW0JKM4DFeia4oj_U1PMDz=kG4hdLEaQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: harden h_shared_count in erofs_init_inode_xattrs()
To: Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000004ac2fa064d478f0d"
X-Spam-Status: No, score=1.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2825-lists,linux-erofs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 952EE2B7190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000004ac2fa064d478f0d
Content-Type: text/plain; charset="UTF-8"

>
>
> Thanks Gao Xiang and Chao Yu for the reviews.
>
> Appreciate your feedback.
>
> --
> Utkal Singh

--0000000000004ac2fa064d478f0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>Thanks Gao Xiang and Chao Yu f=
or the reviews.<br><br>Appreciate your feedback.<br><br>-- <br>Utkal Singh
</blockquote></div></div>

--0000000000004ac2fa064d478f0d--

