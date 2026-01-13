Return-Path: <linux-erofs+bounces-1848-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E31D1B592
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jan 2026 22:06:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drMHp41W7z2xHt;
	Wed, 14 Jan 2026 08:06:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768338406;
	cv=none; b=ciTCBaa7eaDKG0YFudHMjtswd4qXd3myOuttP11GwpsSbOdOMNvfjRcif72r4EQrgynDFDYzqVS+2wrpKvU8iNTgQ7msGiQthld1jmKN22/KtuORtdH0gZeqqUoa+EDjCqmD7tA0Zxdg4cJGoZn+0MNASStrZbXtUw/eDmC83iYWU/Kzr0bC/lf+Cb1WorKOsVw/844XkvLgZXpAFxjMqZ8FsQSLnpgsN4J0Il2DlggTIu/ueEfjAfXcf7BuT8MShwXwsMmHTu71bbl0MuL9oxXfWYiUkfoYF8c4xaQvFZKsBk7BWuPzAjPnSHE1C31woTfVhU/ni8YJxIZeRCyO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768338406; c=relaxed/relaxed;
	bh=jqbRJsomiPWk6cLkmHUFygsj5IDMKDpLe8eU/EmOQZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7b5TMVvab2hTqcdeTkVW3/fjye3XY7pX5z2k0stsEiUCt7OLZGobjGo47zeq8lRl0SmFBF4KNuKtEilaKk6k3C857iUNGBNyOKZU6KZ0GWKAnBsJWhN39Jr/hXMFkLMBoH/Y9OAc+i6RgCgrnaNz7BIkeOMY4gv042Wch8v7Rty0/7ghCXbN33B6jqlC/iA1RWNp8GDhr5Cw5wIDbpAEZ8xMS0Sd/dlZ+Mp4TfG93QID/busRx4BdDgiKRWtwpH/9qvtdbKcLNNBfxii0ITYcnh4jhJDOcCpigFd/EGK5IlRh6hNsmYDzX2YWwNgk0ApNb6o0jEUgG1Z2VN/etlyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net; dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=KFbKNiGe; dkim-atps=neutral; spf=pass (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org) smtp.mailfrom=lwn.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=KFbKNiGe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 483 seconds by postgrey-1.37 at boromir; Wed, 14 Jan 2026 08:06:44 AEDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drMHm4H9vz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 08:06:44 +1100 (AEDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8ECE440C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1768337886; bh=jqbRJsomiPWk6cLkmHUFygsj5IDMKDpLe8eU/EmOQZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KFbKNiGe2YaK8agCCcuhtI6+jquk1zq0gG+KF8tf26qgrt+mu/JiJ+gzbKP6bqQMN
	 o7GNTc4J3fQM8W/8z9Yx+/EG84EKlxLg/7D0V7II0cgTusmeD6IcxuPu8sgGfOQzpy
	 4N4Gkr2u0sDZzk9fId6gcMxp8Ciq4WMgzd/vmlwqjgiD+v3Cy9kMqvJz2MNhhjW7gN
	 lpVos9KUAT0bDV2gX0BhW+OGZIfJ9cCaY9mK+GH8vWLbsEG7FHDMcQKw3rsAHsVS4d
	 Cc/SUpnN4GZzmtLCv3EguW3eyNyTVrc0OnxJvFwbyJ5loGgMWHfxEQXNZaBGW3v4kw
	 xXElLZXpMaoyw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8ECE440C7C;
	Tue, 13 Jan 2026 20:58:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nauman Sabir <officialnaumansabir@gmail.com>
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kbuild@vger.kernel.org, Nauman Sabir
 <officialnaumansabir@gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation: Fix typos and grammatical errors
In-Reply-To: <20260112160820.19075-1-officialnaumansabir@gmail.com>
References: <20260112160820.19075-1-officialnaumansabir@gmail.com>
Date: Tue, 13 Jan 2026 13:58:05 -0700
Message-ID: <87o6mxw7qa.fsf@trenco.lwn.net>
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
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Nauman Sabir <officialnaumansabir@gmail.com> writes:

> Fix various typos and grammatical errors across documentation files:
>
> - Fix missing preposition 'in' in process/changes.rst
> - Correct 'result by' to 'result from' in admin-guide/README.rst
> - Fix 'before hand' to 'beforehand' in cgroup-v1/hugetlb.rst
> - Correct 'allows to limit' to 'allows limiting' in hugetlb.rst,
>   cgroup-v2.rst, and kconfig-language.rst
> - Fix 'needs precisely know' to 'needs to precisely know'
> - Correct 'overcommited' to 'overcommitted' in hugetlb.rst
> - Fix subject-verb agreement: 'never causes' to 'never cause'
> - Fix 'there is enough' to 'there are enough' in hugetlb.rst
> - Fix 'metadatas' to 'metadata' in filesystems/erofs.rst
> - Fix 'hardwares' to 'hardware' in scsi/ChangeLog.sym53c8xx
>
> Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>

The "3/3" in the subject suggests there's two other patches somewhere?

Thanks,

jon

