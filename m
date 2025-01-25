Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F4A1C662
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 06:51:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yggdt329Fz305P
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 16:51:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.133.214.27
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737870672;
	cv=none; b=k0eyqvMQQ9MYcVyFGtqK88uOeOVmEcYgHC8we7+uyHqruQrlmPl5pejHVS25SzJUrl5LTmvNC97zWnJv9qFDrHs2WCrFOGFxZ5TYBBcCuL1kbJ16xSvK2BH7kVShBbzFWlUR4Q83tKqgnutJcKeT0ni8Jge+5BZgP7pL5fXX8wOFsFXTqPR6loqoawmgvsBhOZ36zn0ylf/cg2W1JsC07VQP6sIkQLlVNA8tkeVIOBwBA9FGhODPKGxdFjxggjeba3PVL7/gRlT5pQbvSgtAWQHULPB+TG1cOnWUKnDK/UekyDInawHYj5h34idIz1s+AnrsKlvxnXyPsNMBS/xJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737870672; c=relaxed/relaxed;
	bh=h3Re4ZyxmIjLjbC3kGNe4/eRd55jarqXuwjXB2zIetQ=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=IBa+q7NQyC3GEl7zg0L4ExvE4lFAyc4N5b0Vn2oF9ecxpvgk+7nwJa/bGZvD0qlUIH8knXUQ0hU4UJglDjkxS+hRqhHXoZ2P38gowhFKg5U89WiHZ27ny+hdVnorcW+Oo/7Ci/Rvxv7HuZJxil6Mxpb0vsfAEbip8ifZH0h3L+2OdFCgVZ0wIsKRdxK6xiRWUAadY1izE3OAttw0eBs1la0NB7OhTF2I8KbaDO0RLqZvSwAY3YiYP4OQxTnzMaVlgjCVMOooqhoLzz1CAcL9rS27+NO3NajEsOwgzXveYhpzxm7ehia+J224GS37QGHiIAmODh3/K7Lk5Q6mK2+Xdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=quicklogowebsitedesigning.com; dkim=pass (2048-bit key; unprotected) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.a=rsa-sha256 header.s=202407 header.b=NfBXHMiu; dkim-atps=neutral; spf=pass (client-ip=103.133.214.27; helo=host.quicklogowebsitedesigning.com; envelope-from=celina.jones@quicklogowebsitedesigning.com; receiver=lists.ozlabs.org) smtp.mailfrom=quicklogowebsitedesigning.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=quicklogowebsitedesigning.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.a=rsa-sha256 header.s=202407 header.b=NfBXHMiu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=quicklogowebsitedesigning.com (client-ip=103.133.214.27; helo=host.quicklogowebsitedesigning.com; envelope-from=celina.jones@quicklogowebsitedesigning.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 490 seconds by postgrey-1.37 at boromir; Sun, 26 Jan 2025 16:51:09 AEDT
Received: from host.quicklogowebsitedesigning.com (unknown [103.133.214.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yggdn0dJLz2xjd
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 16:51:09 +1100 (AEDT)
Received: from quicklogowebsitedesigning.com (localhost [IPv6:::1])
	by host.quicklogowebsitedesigning.com (Postfix) with ESMTPA id 44A6B17FDA7
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 08:46:46 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.quicklogowebsitedesigning.com 44A6B17FDA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicklogowebsitedesigning.com; s=202407; t=1737775006;
	bh=h3Re4ZyxmIjLjbC3kGNe4/eRd55jarqXuwjXB2zIetQ=;
	h=Date:From:To:Subject:From;
	b=NfBXHMiufLmsLN+WBckIikQsOwLumCoqixhZ39J7ucx8CGb1fPaebUvoWrKwhg2Tl
	 ZAqYMxGdrmBjFsgRpV2IYXlMS4GOlb/6DNIDJwj+VGvCIqO7a00CDGdauWsmQZbEnh
	 yyPZU+vkZGnewdKyxKUQZ/uuffb71mnw86hZJ6oJuNz8q9hcwxXHCGa/+0pmtyLsZH
	 AL2mVmkA3FaWDekYJtoUFU475DLTFzjGxsS43bRquWE4gTByi+9yC3I7hVQReVE502
	 Qe2S79UgJAhbtUgBH8xFXw2ItmP6JuGlCDzyRe8euxW6Msr/bnB/uSi24q0cn4gqrI
	 VJTPvC/mB9uag==
MIME-Version: 1.0
Date: Sat, 25 Jan 2025 08:46:46 +0530
From: celina.jones@quicklogowebsitedesigning.com
To: linux-erofs@lists.ozlabs.org
Subject: Audio & Video Transcription / Translation Service at 70 cents/min
Message-ID: <1b3d254d33aae3b83ac359be49203526@quicklogowebsitedesigning.com>
X-Sender: celina.jones@quicklogowebsitedesigning.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.6 required=5.0 tests=DATE_IN_PAST_24_48,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Level: *
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

  Are you looking for a transcriber / translator for transcribing your 
audios / videos ? Many researchers / students are not aware of who to 
reach out to get their research audios and videos transcribed with 
confidentiality.

  We have been working for university students across the globe for over 
10 years now and provide transcription service to students, researchers, 
coaches, news agencies / reporters, writers at a very reasonable cost 
and quick turnaround.

  Whether it's interviews, podcasts, meetings, or lectures, we can 
quickly and accurately convert your audio / video into a written format.

  Our rates start at USD 0.70 per audio / video minute for up to 3 
different voices in the audio / video.

  Should you be interested, please do feel free to reach out for a free 
sample transcript of any audio / video of your choice.

  In addition, we also provide service for logo / graphic designing, 
website designing and development or any kind of software development as 
well. Please feel free to ask for our portfolio.

  Regards,
  Celina Jones
