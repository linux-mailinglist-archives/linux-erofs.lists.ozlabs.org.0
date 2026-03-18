Return-Path: <linux-erofs+bounces-2828-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELrQN6h7ummTWwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2828-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 11:17:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4A2B9C08
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 11:17:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbPrh2TkDz2ygT;
	Wed, 18 Mar 2026 21:17:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773829028;
	cv=pass; b=eihyad8aScTM55u8FT0FoMb7WiwEFV8w3WBWBSpbwiR0P18fP+G/Bj5PFNLJAXzCXmEObv40z5S1XdUqF7yvX+/bQaB6QeyaFDUlUQsuFi9tAs0Q7lXPIkxRzOzYVqiUHdPpZVxbUVKcVGD8C5HVSdHyV8Dvho9iI3RIsFASyVGRDPldTj8uK6fJnGV+bX4hvsoo3K03Ifc8J9ForGM9ZVx3w+DUz1Q+/t5BAyBa8QLIQERRcjVNH1NacLx3P1ryIeJk+wnNPQLkFtUICgEC3DUkkCch3CGzJmo+PDWP7bsRj6VEXs5ab6Acbm3VlP3+bHIQW2bljrXYaap5e8O/nA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773829028; c=relaxed/relaxed;
	bh=YXZ8PFYTwXG6fOC17wGlPYlv3anB7NxPV932bPIkTmY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GfldgrSKNT0Jmhbn0NXokze+kxRjsICUoPns7BfN7q9WxBHJ7WGAYkVointi97mbNuFyEJIf7DjclKvCKmMFVSG0pOZn52rn1+KChcWgR92Op4bpsre0DdipV2Ih7x5X2mrnFTb9bAzwv/4jfwUKR/E99YKdmdqXFDhfOHAZ444WWyKGtnx99ho7Hy/OeEKLacOAkgYybPl59Swotf1g5PSD15ZT0zp647iRcEcDj771D40Xn+cUPRsgUEcfFYMYLR1+e6a15Ll4YaH3mIcWzWzuCE+nDDbQFaBf18zLAC57PmF4Rm6uFD5BBupiwwWDJSQ/nHJCGfLYyGcIFHPnjg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=foX1lKW9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=foX1lKW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbPrf38k7z2xVT
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 21:17:05 +1100 (AEDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-89c4b9e0068so2700336d6.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 03:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773829023; cv=none;
        d=google.com; s=arc-20240605;
        b=XWmgealvQnJlh61Qc5wFFbHWgxTjsX+cPvZP+r7r9OA9Vw0lQfwJlQG9N2Jv5ngx9F
         ShrBcThslbaszdp+MZdkq14jo0JbaJP+2mdz7OI4QVTf5ZcQNfKO8WJyM6IAdA4utjup
         R81YxPn88BYSaphZ+yfHanw8UUi0uMbDD0CP4i8EDmwaXVP1Qi4tdlN2+b/Bap4ogrzm
         7a1XnoPEXszCKXejN2S1n+l+iOGzasLIvi28QU7rGjEoMbGYdWZm2ao0e6t2m3BOZDaw
         8euao1pVAbviIh1N+7G/ijTEeGxwzoNe71vySpp7sbLDnWz57muOgJVYht0Tdul1Q3Wq
         q/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YXZ8PFYTwXG6fOC17wGlPYlv3anB7NxPV932bPIkTmY=;
        fh=uoIOzD++AJrcJohg/yky2E83HvH64RowgYbXhTFRKjA=;
        b=EWdZHyDh+Wvv7C0XlaOvc2ZYMa0VGvrR2JHxdyUyr7FNosttwHfHqO1selbDOZUnlB
         OL7dtjqu/UKPaA1TDLV1x7+CAeSIMlw+GB9/y2nIFzqR2WIsOY5A2gq0xqWfJqvs+mbz
         hUXhCFmc6lNF4h3IVx4YL+F3nohXt/mVLIMQQVWZQUDKvjJItDw6vnwB3SlGvpi+Iu7Y
         yqANGY6OYeZmo7+MS5CmkIv7P1K5oltKsZQobp0ERvJEw8/d/UQwPSrjeZ58jGE4FQDv
         2VOVy0e2eNksXOGIRxtsfbwqEoCNpmJZJlq9aZfQNlha3sUf4GuHCkHQKGZwlZuuyRzb
         mvpQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773829023; x=1774433823; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YXZ8PFYTwXG6fOC17wGlPYlv3anB7NxPV932bPIkTmY=;
        b=foX1lKW9FcFEFoq5wa2AKSAXmKs7aaNu3CzyyDalaxog+3kM4howhCgX+zW7Cbm30s
         XbHaBwJKEA7E1AiwPRBdJKCTLFB626MKbNic5LmMZNFHj3J9jbChVQGRDEBxv+v60qvG
         an/t/pl0kNjZpEl5kXjLCJa6WOZQghckJDlAV2+bLPrAFxLtk9Hg7lNRcBz5lctIpq+K
         4at5/0HMbnRqpgZLDg8YYutZKJZM6SdsipYrXipYdtR0Xqs9dqitri+H+yP569ZyW+XG
         K9Z2Y6RU0XnOS2hPJxDN4zwq84v2+FaXxg8sjmOEqmJtLsDeZ7qFAe/TtLCf7yjUmWpF
         I3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773829023; x=1774433823;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXZ8PFYTwXG6fOC17wGlPYlv3anB7NxPV932bPIkTmY=;
        b=ScwOoe2Q67gBDcjNSpxVypvQzUxe3D4FimeFW4+MlocgO911XYAIakiWI263262NXd
         llYJ15QI4TNeIrbhGvDosTnGVIV+VNbnPJZ/RvYdbxELGaZR4yBDL4R8aNbIx3f4uLVT
         xQGOtZDRR1jQpOa8y5erMJyLWwdUdVvJmGg8Gw3ilnsp/bTnjev5LbfoJkmIgzgY6g/j
         I3EbjVKyTGuPoT1sMLKBmsByLTlSgMH6d3GhZ2zXbjOEjtEf5ipe5fDNYBD0bmilSZMP
         BJfj8pes0h2Fq0Gpm5qdOGhrS1Oscb6qxAh84EDMlL5qJmxzTR7fhDuwjl8ReOUYCAzn
         0dKg==
X-Gm-Message-State: AOJu0YzM/n2RPZk78NO1Cv+LfHI25w2HJbAQCPYfWVUtTrFVzHRJ3Ysv
	85se3xOtdO3lcNu89Ah8anH+VUoNbWugJ7fC1+Pv8z4ZhvJQzht/uCpzAHQ4bdpGRpXBr/90awV
	NtA3WSgRgo4Jxzko1wGWln4DLzqPd1BM=
X-Gm-Gg: ATEYQzwR/4wQBoifVFz4g/IOYZUI6ALsUXPUT5mRQITaLCGHWySKTuyBa0B4KMIYHrE
	CM4I7nbk13V75v64+hYWIwTiW0EBz7pn4eOFr4pfI0NAH+Eqnv1VTAjRvtNUb6u8h9HIVLUSCTz
	jv/wTUIenf+lPeXGcbWFR37ZQ8yCY0rteSPSD+/8/HBeZdtvJn9RVVPO/YzSbjPuIZv+nY5Jfvz
	7va9ozrq8orwmbfxcEBkR1/AzqP5tk3t2C7l5Xy1bFu8ugvexiJsyytEZvcpGEkHIigEtwjuVrC
	JpkqKr3mz4LzKL3laosrhnkGYQ3W+EyUfK8DuKgkxkaZEi3qIiAUOlTu7JKh76w/mVVYOkLGOI9
	+poi2
X-Received: by 2002:a05:6214:62a:b0:89a:564f:bbab with SMTP id
 6a1803df08f44-89c6b57024bmr35433106d6.3.1773829022839; Wed, 18 Mar 2026
 03:17:02 -0700 (PDT)
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
From: Utkal Singh <singhutkal015@gmail.com>
Date: Wed, 18 Mar 2026 15:46:56 +0530
X-Gm-Features: AaiRm523UiLnAUwl0QVkXA2tycQiAOxbGDWnB9gtMMMbl9hCtt3PtezgZCPhogI
Message-ID: <CAGSu4WMAt0cOrJEx1G12yZGOA=r57=H9mnby0rstX40Pqt0pqw@mail.gmail.com>
Subject: GSoC 2026: interested in multi-threaded fsck.erofs decompression
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, Yifan Zhao <yifan.yfzhao@foxmail.com>, 
	Chao Yu <chao@kernel.org>
Content-Type: multipart/alternative; boundary="000000000000cc7878064d49c032"
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
	TAGGED_FROM(0.00)[bounces-2828-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:yifan.yfzhao@foxmail.com,m:chao@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,foxmail.com,kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3ED4A2B9C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000cc7878064d49c032
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao Xiang,

I'm Utkal Singh =E2=80=94 I've been sending patches to erofs-utils and the =
kernel
erofs tree over the past few weeks. You reviewed my h_shared_count
validation patch for fs/erofs/xattr.c (the v2 that switched from division
to multiplication, per your feedback). I also sent the ZSTD decompression
bug series (missing ret =3D -EIO and unvalidated frame content size), the
deflate buffer overflow cap, fsck xattr verification decoupling, strdup
NULL checks in lib/tar.c, and a few others.

I'm planning to propose the multi-threaded decompression project from the
GSoC 2026 roadmap for my application. After working on the decompression
and fsck code paths, I think I have a reasonable approach in my mind how to
approach this:

Since pclusters are mostly independent units, the natural approach seems to
be a thread pool where worker threads handle decompression of individual
pclusters while the main thread walks the inode tree and coordinates I/O
and output ordering. The tricky parts would be managing output ordering
(files span multiple pclusters), handling shared pclusters correctly, and
making sure the memory footprint stays reasonable with a bounded work
queue. All four algorithms (LZ4, LZMA, DEFLATE, ZSTD) would need to work,
and it should never be slower than the current single-threaded path.

A couple of things I'm not sure about yet:
- Would you prefer pthreads directly, or is there a threading abstraction
you'd want to see in liberofs?
- Should I scope this to just --extract, or would --check parallelism also
be useful?
- Any other design preferences I should keep in mind?

I'm planning to submit my proposal well before the March 31 deadline. If
you have a few minutes to point me in the right direction, that would
really help me write a stronger proposal.

Thanks again for the reviews on my earlier patches =E2=80=94 the feedback o=
n the
h_shared_count iteration especially helped me understand the project's code
style better.

Best,
Utkal Singh
https://github.com/Utkal059
singhutkal015@gmail.com

--000000000000cc7878064d49c032
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao Xiang,<br><br>I&#39;m Utkal Singh =E2=80=94 I&#39;v=
e been sending patches to erofs-utils and the kernel erofs tree over the pa=
st few weeks. You reviewed my h_shared_count validation patch for fs/erofs/=
xattr.c (the v2 that switched from division to multiplication, per your fee=
dback). I also sent the ZSTD decompression bug series (missing ret =3D -EIO=
 and unvalidated frame content size), the deflate buffer overflow cap, fsck=
 xattr verification decoupling, strdup NULL checks in lib/tar.c, and a few =
others.<br><br>I&#39;m planning to propose the multi-threaded decompression=
 project from the GSoC 2026 roadmap for my application. After working on th=
e decompression and fsck code paths, I think I have a reasonable approach i=
n my mind how to approach this:<br><br>Since pclusters are mostly independe=
nt units, the natural approach seems to be a thread pool where worker threa=
ds handle decompression of individual pclusters while the main thread walks=
 the inode tree and coordinates I/O and output ordering. The tricky parts w=
ould be managing output ordering (files span multiple pclusters), handling =
shared pclusters correctly, and making sure the memory footprint stays reas=
onable with a bounded work queue. All four algorithms (LZ4, LZMA, DEFLATE, =
ZSTD) would need to work, and it should never be slower than the current si=
ngle-threaded path.<br><br>A couple of things I&#39;m not sure about yet:<b=
r>- Would you prefer pthreads directly, or is there a threading abstraction=
 you&#39;d want to see in liberofs?<br>- Should I scope this to just --extr=
act, or would --check parallelism also be useful?<br>- Any other design pre=
ferences I should keep in mind?<br><br>I&#39;m planning to submit my propos=
al well before the March 31 deadline. If you have a few minutes to point me=
 in the right direction, that would really help me write a stronger proposa=
l.<br><br>Thanks again for the reviews on my earlier patches =E2=80=94 the =
feedback on the h_shared_count iteration especially helped me understand th=
e project&#39;s code style better.<br><br>Best,<br>Utkal Singh<br><a href=
=3D"https://github.com/Utkal059">https://github.com/Utkal059</a><br><a href=
=3D"mailto:singhutkal015@gmail.com">singhutkal015@gmail.com</a></div>

--000000000000cc7878064d49c032--

