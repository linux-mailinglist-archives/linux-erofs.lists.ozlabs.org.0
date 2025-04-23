Return-Path: <linux-erofs+bounces-218-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F26A99884
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Apr 2025 21:33:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjTm32shtz2yFQ;
	Thu, 24 Apr 2025 05:33:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745436787;
	cv=none; b=Eua69kfG9OjceU9kAA8kbITVZSzAP7IdeAIGh+BsRQBB5DZqY/Ay6Ccj8xX0Oz8h+Zv+/e79337j2i3OsGh5qhKEuBm3ylqYrshauBbzYYHRyMxPffWFKe0whvoYUPcZ0vkLsqNDEi6CnSRvzOzyDAbz6CbuMXHswn/zwk5ofRT4ZY6Apvclq+/Q4Krv2H/KGjV3u0Jv1GvcbqnZR77QnGjCk9YWMQ3G2jvWUs+PD9Hb9nEER8tmdQHhQmuM/bqjYXtn+xjGxaijFm9eDkHw3vb1F4w6aB2l/lg6b7KbbRSchTJcQ/+2bw5xprro/n2VNpABn+888oGb5QwdF8Jd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745436787; c=relaxed/relaxed;
	bh=VoAQ3YeeLxL6RbWpKk8apPJ0PhNhNmlkBSEWVgih6hM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=dG2D5rxNG2nRD/hy/CRKd/qyP1hgmU48GlRxo6uoDrixO9SnD47Fg/NqCT2JbOifdBhx7U6/QKzsUfs2eAlSk/UWM6yqxfuQF1fFwpizeyul0cbdiN/MBatqRhu+oCxfP7DvsGDaxqcANOFsFHo19Qra8x+4OUSaF2K0j4dQZHuyun2cxfW3aCmED0TClPhoRX56+lBtiDTkTWPfQqOA8uBLjFUD9UkkakeLtgzq111qOO53fHU58uJalTGViP1+RTlVh1dplRzi8FeyksHcykGhSWUGEgckO0f7KvdwydsTt8ALf4BEWTLk9EycSTUH66CkD2Io+Gpsp0MVYhoxFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xn--tkuka-m3a3v.nz; dkim=pass (2048-bit key; secure) header.d=xn--tkuka-m3a3v.nz header.i=@xn--tkuka-m3a3v.nz header.a=rsa-sha256 header.s=s1 header.b=FqnRtuSd; dkim-atps=neutral; spf=none (client-ip=185.205.69.214; helo=mail.w14.tutanota.de; envelope-from=sh1efs@xn--tkuka-m3a3v.nz; receiver=lists.ozlabs.org) smtp.mailfrom=xn--tkuka-m3a3v.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xn--tkuka-m3a3v.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=xn--tkuka-m3a3v.nz header.i=@xn--tkuka-m3a3v.nz header.a=rsa-sha256 header.s=s1 header.b=FqnRtuSd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=xn--tkuka-m3a3v.nz (client-ip=185.205.69.214; helo=mail.w14.tutanota.de; envelope-from=sh1efs@xn--tkuka-m3a3v.nz; receiver=lists.ozlabs.org)
X-Greylist: delayed 520 seconds by postgrey-1.37 at boromir; Thu, 24 Apr 2025 05:33:06 AEST
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjTm20nYfz2xs7
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 05:33:06 +1000 (AEST)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 9A71F7E7012F
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 21:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745436262;
	s=s1; d=xn--tkuka-m3a3v.nz;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=VoAQ3YeeLxL6RbWpKk8apPJ0PhNhNmlkBSEWVgih6hM=;
	b=FqnRtuSdmfpGUmfxhgX2oYuYrObuK0sGvKm3Z/zyTBMv7mrs9g/FVvckM0XkS5HS
	tLqv6b4Q4Ct/8k/FtZ/h/T70cKlDsyMy1L2CsiNdpGk7eK9wrm3ySTcMoSpr2WDhRdj
	EJo/BUumbVzOWp3ugFbS7e3z03G5Y2vJ2dSPhnCaAgE2I5NQno+Gts02fDyI97WFcLl
	Q7Exf6NeFPsdMH2kkvO4gjTWimODQHK1EO6RJugf0nr16V3YBE/GYJ5onP5H89uZ14k
	JiCYsViVWh7xcTTICP+fKLHYMU5Mc3h2ymE4WIYdMqzzK24j8YMYXg4dB29hh/0I65y
	yyVSMfF1IA==
Date: Wed, 23 Apr 2025 21:24:22 +0200 (CEST)
From: Simon Hosie <sh1efs@xn--tkuka-m3a3v.nz>
To: Linux Erofs <linux-erofs@lists.ozlabs.org>
Message-ID: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz>
Subject: [question] Status of dictionary preload compression?
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I've struggled to determine if this is already a feature or in development =
or not (possibly because of overloading of the term "dictionary"), so I apo=
logise in advance if the following brief is redundant:

Compressors like LZ4, zstd, and even gzip talk about "dictionary compressio=
n" meaning to pre-load the history window of the compressor and decompresso=
r, before the file is processed, with pre-arranged patterns; so that back r=
eferences can be made for text the first time it appears in the file, rathe=
r than having to build up that window from an empty set at the beginning of=
 the file by encoding everything as literals.

This can lead to an improvement in compression ratio.

It's generally only useful for small files because in a larger file the bac=
k-reference widow is established early and remains full of reference materi=
al for the rest of the file; but this should also benefit block-based compr=
ession which faces a loss of history at every entry point.

So that's what I'm talking about; and my question, simply, is is this is a =
feature (or a planned feature) of erofs?=C2=A0 Something involving storing =
a set of uncompressed dictionary preload chunks within the filesystem which=
 are then used as the starting dictionary when compressing and decompressin=
g the small chunks of each file?

In my imagination such a filesystem might provide a palette of uncompressed=
, and page-aligned, dictionaries and each file (or each cluster?) would giv=
e an index to the entry which it will use.=C2=A0 Typically that choice migh=
t be implied by the file type, but sometimes files can have different dispo=
sitions as you seek through them, or a .txt file may contain English or Chi=
nese or ASCII art, each demanding different dictionaries.=C2=A0 Making the =
right choice is an external optimisation problem.

