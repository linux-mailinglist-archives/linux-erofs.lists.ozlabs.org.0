Return-Path: <linux-erofs+bounces-2840-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMpnHC96u2m2kgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2840-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 05:23:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403D2C5DF3
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 05:23:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbsxb6t4Xz2yZ5;
	Thu, 19 Mar 2026 15:22:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773894179;
	cv=pass; b=QCPPcHpG+UdF4WQ61ogSZ56aw3ELR+/IEmjncxZD3k0lq0W9CwLtHufWWyoXJCRWDfHpObLZvOR1vh69RhBt4br38rX50Zog5YbnUEGJFPX+ydNsMlxSTb17Uw7gefcBshMBnOWDA9iK1x9K4XD8N82BhGjmxzyqFN30wjztIKNYAD8auQjXEIeW7oQts9avwlKGxLEROphaFMcf/cci1pN2lGNSOrHfpv+SDJG0IsADqgYvdvM/pyx9PMLPRd+UqCSNe1AcFwO3YQNhh8EJIKjl7aP2x6IsNuG1oz007GbQaaJUePfWHgZBzjcSKZci+vCpa/PmoMJ0VLP2QGd+3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773894179; c=relaxed/relaxed;
	bh=mPJ9KrpSb7WAaQTDzN3z617vyFkow66xQB1AVDyLmA8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BYD0OQdab37IfF8G+gWMWk2PdaQ9Ayu1q51AuIYeCO4sB4pGjEf9eOLVNUK87cXoRVdJO74YfgDJJhhjWEzkeyNFkG1eF64mVPAheSF3e9iLqEAoeWAbXv0HcxqjY7Dtlcn0bCxe88PoDHGIiKdfZ63Pl51JpwirWBvT0JtLjX96vMttvHOxkGp+9/2MCVqSbYlEmLPBDrQQ6odKusg7u/ZEVB0v+doIyycYXMk3tnXPz9Z0S8eAF3N6tcR46KTtTz2ZnN+UJk2Rx/xmt771ZMsrXyoO9XODhdHKXllaMeNO/RULx84YzxdJTZcWMD9Iz7+yoFSima4poVsaVOuQQQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WU1fMTkl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WU1fMTkl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbsxZ5WRFz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 15:22:57 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-89a59978711so619956d6.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 21:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773894174; cv=none;
        d=google.com; s=arc-20240605;
        b=RNXxzCiKcw+GcGiGR62n6C7SeJBcTvRMrq5LOUaKNn8ypsCc0Brtjw8lAFUfkIe8pE
         ksNhTvJ0LVaro0f4TRQ9IpR4/cbzdP1zdkqAfKLWAjGJDUXnTFkashhmS2mq7e2y4tkn
         nvi/h/nRycDrtv1V7XdmNuNZFZJ3QszVnU+3wzCcuGtq/rgIXBdmUrIdb7w/fMS8pncB
         QX39vxz8TmKweorqnwgmRbMQ7QGgo3qqI/gGGvk+HxT5WUjl3lfna7pE4ibjEOyYcD4h
         boY4F3kWh1589mR2uvU0UjwbS/G8iBTW4w9GIa7AyHiYP7qQgFiXWd/UTogp3wFXApxD
         T5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mPJ9KrpSb7WAaQTDzN3z617vyFkow66xQB1AVDyLmA8=;
        fh=HYxd2zVsIO1U7oEE0TukJgkImaunvwXKSuEoJqxUmtU=;
        b=V2nV8goT0Iyouf9i2qykXzT50HIRpaIcgYh7jf3UUHYiV7uBeOPUU/k1jHkmgflsSg
         ojJUw/GiRO4rRWjKE9CpbtmrfraVELKDSIF5pJ/9Hw+b9IDST62n/AdrGIofrlhP/99+
         iRQaExjvcqfkSnqZC4wwPnGWSwAdmTtqp3e3BUh6gMgdmK4fRn+tOPHds2GBiZtr+ESN
         TVIqVgeRTWhoE1PREPD2Q6YAiZsDrdouAseSjFrEzqf7LPgybaths1Z4AX180n/NXvsl
         GVrtVC6cjmeuQs06pRWeGSNOB+e0JMcadiZa07fGiMeWPGZ60kmPobP5a8tIWDDxWrPt
         5PXA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773894174; x=1774498974; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mPJ9KrpSb7WAaQTDzN3z617vyFkow66xQB1AVDyLmA8=;
        b=WU1fMTklLdHE5DWq9nhbP8m8F9LNRvvJdbntlXKAERw8n5dfJHDRVKwCSJc8SzO9VA
         AFmtW9XHFbwW0EQgjdlN8aMvE9hSKqic4wDFdmNOkesQUj90yOa6KQcZsCKPzd4MMdVw
         twq0UrGbGytcPaH6DrcvAApLSYb8E1Qs6z1cxirtsSDVHgSKep1TV1wWv+zuDYFwNBGA
         bmjgCZ5KKKbavMjzy0VufksrlepDeO84riQYy5GS75d0EH/J4OLkXKeVS0566N5GRWjt
         /TD2GwFWw3S68W623Lm7aoatnAAwe/VEugLE0DdPlDujEqkEtL2E0+RcK+XtwLYOGAI0
         f6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773894174; x=1774498974;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPJ9KrpSb7WAaQTDzN3z617vyFkow66xQB1AVDyLmA8=;
        b=elvrBom7mtepv2LagAvwd1nWZzgWx0xHNyuR+T6nAXUeLo3J8w4eQM08MYEyD73+GJ
         OwNQCl8rdUhNebFum5yRn3SuSjPCOIHVKwLNs5AEUNgwUeFp0iKuy8icUrlUgz342uEU
         tchTgDRgNG2ka8GtYVQ0fkVT0i6I85m6A6XK8LGeHp8vqiVBuUq/y4TxZHlHr20pE/2A
         JKrX1GBgl+oc3fNGDPQpu5WFtwggVF4iq4gW2li5nlcaaYCdp0pvIvWKkcQDAXJ8GcKq
         ZQd1YwKk7PQcRBoZoMxRao/rw/FYPDQOhzKa5NXkXoh3A4PwwFRZfeRlVfwFuTk76F13
         pK9w==
X-Gm-Message-State: AOJu0Yw08Hx8+gr0GO+FN882ldsI84NKms7B81CdUmhhXHxpWnGfBkcp
	SAuUg7az5V8m1oteAB2M0ALph13A3SEYOhSUiauE2xmJY/ITWc7AOhf1P+0oioy6G8vsmVO0T4j
	0XIvbBfbvMAavM0NlK/XilvVFeTa+Ev0=
X-Gm-Gg: ATEYQzw3nj39g/xWwwX3clkeFHgMpLfHSj9oomqOh8xk7Wphe122IoXUpZR/iu6wFLx
	Sf1WUMJ81//R+eRna1vpQXw4F5B3uaqAWxnWvKcSyAqajxQcM3WcIUQOXxrmpFWLfTgtz9HVocj
	wP1U7K7DChjqh4PYaN8y3UF+cIijLHQWJoY+4AN4FLFeGpa/BJTi4sRP0X73WQubAq7/viihI/6
	PVitCgRj4zq8QFsexyP5wF4vKBRtgcVx0XUetwFOopOVfQrUWHnBe4JxfZVjgt47HGefJpoNax6
	sU+Zfa373xz3nqBd7TUpPcGMcafK+q/OHQLgYywGfpvIquTXecknqIRmQpyJUI9v+hVI
X-Received: by 2002:a05:6214:2a8f:b0:89a:732e:f805 with SMTP id
 6a1803df08f44-89c6b5f5b75mr66918636d6.7.1773894173906; Wed, 18 Mar 2026
 21:22:53 -0700 (PDT)
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
Date: Thu, 19 Mar 2026 09:52:47 +0530
X-Gm-Features: AaiRm50ftGltMoOTJwSUkYUQrVJtL1BuHB1wUnfLNIchWZJQiDAUNuK7HtHGfu8
Message-ID: <CAGSu4WNAFw=yChmynVCYSfJiSJ3LbohTjV97JsJK5EBipwz38g@mail.gmail.com>
Subject: Re: Incorrect Cc addresses in my recent emails
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000001adb2e064d58eccb"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2840-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.986];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,get_maintainer.pl:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4403D2C5DF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001adb2e064d58eccb
Content-Type: text/plain; charset="UTF-8"

Hi Gao Xiang,

I owe you and the list an apology.

The incorrect Cc addresses in my recent emails (gaoxiang25@kernel.org and
yifan.yfzhao@linux.dev) were my fault. I used stale entries from Gmail
autocomplete without verifying them against lore.kernel.org or the
MAINTAINERS file. That was careless, and I understand why it raised
concerns.

I have removed every stale address from my contacts. Going forward, I will
verify all recipients against get_maintainer.pl and the existing thread
headers on lore before every send.

I also recognize that the volume of my patches over the past two weeks has
made your review work harder, not easier. I will slow down, consolidate
related fixes into proper series, and focus on quality over quantity.

I appreciate the time you have spent reviewing my work, and I take your
feedback seriously.

Best regards,
Utkal Singh

--0000000000001adb2e064d58eccb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao Xiang,<br><br>I owe you and the list an apology.<br=
><br>The incorrect Cc addresses in my recent emails (<a href=3D"mailto:gaox=
iang25@kernel.org">gaoxiang25@kernel.org</a> and <a href=3D"mailto:yifan.yf=
zhao@linux.dev">yifan.yfzhao@linux.dev</a>) were my fault. I used stale ent=
ries from Gmail autocomplete without verifying them against <a href=3D"http=
://lore.kernel.org">lore.kernel.org</a> or the MAINTAINERS file. That was c=
areless, and I understand why it raised concerns.<br><br>I have removed eve=
ry stale address from my contacts. Going forward, I will verify all recipie=
nts against <a href=3D"http://get_maintainer.pl">get_maintainer.pl</a> and =
the existing thread headers on lore before every send.<br><br>I also recogn=
ize that the volume of my patches over the past two weeks has made your rev=
iew work harder, not easier. I will slow down, consolidate related fixes in=
to proper series, and focus on quality over quantity.<br><br>I appreciate t=
he time you have spent reviewing my work, and I take your feedback seriousl=
y.<br><br>Best regards,<br>Utkal Singh</div>

--0000000000001adb2e064d58eccb--

