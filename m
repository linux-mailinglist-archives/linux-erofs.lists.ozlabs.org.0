Return-Path: <linux-erofs+bounces-1141-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B558CBABE58
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 09:50:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbVbc0Lw1z3cZM;
	Tue, 30 Sep 2025 17:50:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d502"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759218635;
	cv=none; b=G5qsEiaolurRsJ+sulIs6Qaqs2MfNICMqFHL0xeq5Gd4YbSExqCChSpfzW8QAPZNCPHie9S1U19wyGhZhKgLqbuLSw/BdFx/RpF1eJQcS8CG3AgXOTT3si5syvbL0AYuPacVGssyzLhnQW09evZUOZVyzjNpGcWGP8UnrImHiZO2p5uZo+HlGP5+F+DQkVgxpO3lAFZrUljGLcMuN24m7M1a+tUfMMUx5t2kG1OPfHxZyiLtGXuIAaqn1JkDNqD+tBHHJDW13flJhMfme0BqYII2DIKZcuJFhew2MKSxVajb9fkXUEx2KQ4S4sbdFm7dCkxZLpigjrUb3Dr7pmjQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759218635; c=relaxed/relaxed;
	bh=p8PkIXa81gKlgOD0PhXGCpzZjCX2jOUCFzXigZnn1oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HgAMuS51Dy8NR7y+2yaaePz8jnYeiXALDGPVXu3DwptzyQ8IuwTib7GGau+8W9i3SgaQINTD0rynWK0SBO5Htic7Fj8TTn5P2jQo39v3Ey75fbKrKqt4jgsqomvJdQHFH7pkHXPmLoo2neEoN01KGf9EFZmagPBBkbq1KBugD2T0oSdp9qAsyGi1oO/GHeJuUXSUP/MJoLRwaIp5Wr2mob5pbO9y1olzxbuddCEr211Xb0TXKq/WO10IhWHZL1L49q9YapXXGzgQvZIrJ7Vs4LN71m9eVxX3hcYwSMASfPvqTLNjvO3qbJtyBrHF3cDm2e5TF7PrXxeQoJVpKwSXuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=flant.com; dkim=pass (1024-bit key; unprotected) header.d=flant.com header.i=@flant.com header.a=rsa-sha256 header.s=mail header.b=uiOX0ya6; dkim-atps=neutral; spf=pass (client-ip=2a02:6b8:c0e:500:1:45:d181:d502; helo=forward502a.mail.yandex.net; envelope-from=ivan.mikheykin@flant.com; receiver=lists.ozlabs.org) smtp.mailfrom=flant.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=flant.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=flant.com header.i=@flant.com header.a=rsa-sha256 header.s=mail header.b=uiOX0ya6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flant.com (client-ip=2a02:6b8:c0e:500:1:45:d181:d502; helo=forward502a.mail.yandex.net; envelope-from=ivan.mikheykin@flant.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 477 seconds by postgrey-1.37 at boromir; Tue, 30 Sep 2025 17:50:33 AEST
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbVbY0y7cz3cZH
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 17:50:31 +1000 (AEST)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:2a1c:0:640:8b3d:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id F242B81576
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 10:42:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HgYHni9L0Os0-JiGM1Wm1;
	Tue, 30 Sep 2025 10:42:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flant.com; s=mail;
	t=1759218138; bh=p8PkIXa81gKlgOD0PhXGCpzZjCX2jOUCFzXigZnn1oQ=;
	h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
	b=uiOX0ya6HCXajKsLId2/qXBa1K8hl5xnMHuDK0s4caji7Y6mKuMvBkkhudlrkXWZO
	 wNnDaKTW4Fr5kd3rUgd8oO5WrTMHjP/LgvdSPpHhpTBwh2lrYIAJdSs37c1Y0BJpQQ
	 YfACQzLjAZOkS6NvKaDjMmncAFKSSZhi0syHMbjo=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@flant.com
Message-ID: <c5318494-be05-452e-8f1c-626de696c0ec@flant.com>
Date: Tue, 30 Sep 2025 10:42:17 +0300
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: tar: support archives without end-of-archive
 entry
To: linux-erofs@lists.ozlabs.org
References: <20250929133222.38815-1-ivan.mikheykin@flant.com>
 <aNqcvDiftM3ST7Mn@debian>
Content-Language: en-US
From: Ivan Mikheykin <ivan.mikheykin@flant.com>
In-Reply-To: <aNqcvDiftM3ST7Mn@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello!

On 9/29/25 5:50 PM, Gao Xiang wrote:

> Could you confirm how docker/containerd or podman parses such image?

I confirm that images with such layers work well at least in containerd 
with overlayfs. We encounter problems during experiments with containerd 
and erofs. Also, GNU tar and BSD tar are good without end-of-archive zeros.

> 
> Because the POSIX standard says:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html
> "At the end of the archive file there shall be two 512-byte blocks filled
> with binary zeros, interpreted as an end-of-archive indicator."
> 
> So such tar layers will be non-standard, I wonder we need at least
> a erofs_warn() message for such tars at least.
> 

Good point. I think I can add erofs_warn() message to the patch.


P.S. I've noticed an interesting detail after submitting the patch. 
Produced erofs image reports an enormous file size after conversion error:

$ mkfs.erofs --tar=f --aufs --quiet -Enoinline_data test.erofs 
test-no-end.tar
-rw-r--r--    1 user  admin  2199023255552 Sep 29 13:43 test.erofs
$ du -sh test.erofs
4,0K    test.erofs

-- 


