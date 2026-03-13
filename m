Return-Path: <linux-erofs+bounces-2685-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHbvMVjQs2ncbAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2685-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Mar 2026 09:52:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE927FF84
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Mar 2026 09:52:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXJCS4qX5z3cJk;
	Fri, 13 Mar 2026 19:52:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773391956;
	cv=pass; b=FLe/X/L/qPec6aYdsrV0xYk5t/uNMfpUd793ZiruPWk041C2Hhpf/FCBvB51z7NQGId5okhewCQT/ituLhg/NlGwF0GIVTcTzJ2moI7jvzFK1oSEIeHsf1WaQNJDAbUF7LDjxlR+FAXv5JFPMFrDS6m74cX1iGT/ajtlHgdKtxKteOsJBj+PdGvbHL4nOKl8hwGbHW5L3gOvIwwZRrcxAOrbmoLC5RV6gDQMFwQgT4VGN6mLrDNpLIrqJPhdXkKwSxZhnHjSUA3iMgAWYdQVX/XUAUZ1RK5VMUIBisBDhNhC2Wu4DQrHhxM9rDZOdoi7LsfdzfE5MInR4nkZjgqTpw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773391956; c=relaxed/relaxed;
	bh=C5vwVuyfgvZir0tYszdsRlorCdfBQqqbHF8qRE8bu1I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ejmzlH1I0g06eZmLvTE6e4hT7mf23PsQ9jO7CV0SzeMgy2Ijeo610sdtlCA5zxwHSK0/Cdb1uq+WKH1UDLPUeOqYvSNTlz+i4SYCSU+p89lOXpHkHqVZeanY7PwqlL0He8ih/48gnv5foj3A+p2g46qToKJy1CjnGvNhtPiSfeRwLHcuQNxOzqOpLUSDqEwgBaFR+vdNFmwd4Xg3YiGdq184Hc/unVldDZpC4EZO6Sp6KYzmxltX6Ol6WGryAiKGT+YTno0lc8bZr4hwMY/X1pjbtrSVGbvFd7ZOlTth/U+/18nmHy6ZPJuwdejMWW0ocLvRkccp6ut3xR82la4AVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FsEWI9M1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FsEWI9M1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXJCR02fkz3cGf
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Mar 2026 19:52:34 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso3597214a12.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 13 Mar 2026 01:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773391951; cv=none;
        d=google.com; s=arc-20240605;
        b=NchMRq6qvfDtKFVy/RRvFct1FY//FWMsKTwqpFYuEpNdMUIHeg/IFa0sOntomcufVk
         58+woc7ai0x93ZEeJcYHPYqyUk5XuqIBW92WsaY6lRcHCd+WfD/Of/v4BXANgtt8cpFp
         upyNDkAkIDQlim7X0reNf3yLc12UWzyzLGuF9VUoPCjDhQgMXfwMXY3u0JAtCpu6nBn5
         WTCgSis7tAwVJE93aDrDjgOYyf1v7r22TGDnFQJIVb6vrcj7OyIHQDw3kCFB1ojWdKFn
         hnfD4zBgXylH02Iy/gTFpIowhQdYeTasJgRt/wfsPuuaf52LeiP9acYEw9lN8iGgbMSJ
         dkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C5vwVuyfgvZir0tYszdsRlorCdfBQqqbHF8qRE8bu1I=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=UIj9D91liPrD4gQ8T2QsWLosEPeL4Oaxnw60aOFvvASUmuPZpZhZdXW//cmN83t2vN
         DNMw/Woe9tjzKcxa3rkFoletKZCvMy0isp3gjud6rDw2bOcHtbXxEg8SHFjXQpKCu1Jl
         KtfD3bO7PSW1+xtJtFPrA5YbLGS0YaKgABxCXOfkkBnaNEGdhkt3V22Na27UnWPO9lq5
         V3YQbFxYEXdy/jAQPgVxmfK9RJ0ZUDumywle/OBTyQlhvjSS9VZoWO5NdPlAlKC05rWp
         GtoCvq8uyohKFohtykQW1J4Vhr/dWY8i8YtCZ8IjVhKflxv5IfZjAtzNZ5lJo15xVjaO
         ekyA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773391951; x=1773996751; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5vwVuyfgvZir0tYszdsRlorCdfBQqqbHF8qRE8bu1I=;
        b=FsEWI9M1whxIxLsWTauH5fqaEzXAyL1LRW5CWdNB9qQwcC2IHyH3L8oE53eHips9w+
         hOPZUS1c5UClW6Dr+PJbto3mhYVX+EWR6GRDvLYj3MoQqDTGXv39s0selbJIVP95+xvA
         HvktGFFGBywmz0T5f4lUS4nue1/IQhTw/9BEqFcG9BaFmjo2z0yaB3S54EQbqbyXIcYB
         C0Mt2NzajYZDVgG4nuE/R7Fk5wex8hQf1ChyuogdoAe+s7Lg9D5z/ticAxlzxdhOOdV6
         407uExYoieqs6KHgQxQozUvSTbYNqVK47EOv0GhqRi/jvcD3T4oUao6TsbKb3ptonm/8
         hI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773391951; x=1773996751;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5vwVuyfgvZir0tYszdsRlorCdfBQqqbHF8qRE8bu1I=;
        b=bygJWOlRfJkY4WZu9N34zbiwFOu7r2BzNaf5yZHsHz8U5QwBZ65VwhiKxc/zk8S7bm
         XE2qGN5bfte+B9b/AEOTpWsSwI+Z9OhEQ1aCujlP/uOOr1GwmIRX1ElKfcNOTT3Sjh+m
         oUFV0quFqCxTWDjTaSFITPMe+PdgM6PYtHJ046YnBQe1lwyvJIGhC6OhRj+sryheyYja
         yVAdZ5HkmsoYYJTxCSnMWxduFnC9XRF8pMrhW6LhlPluvNqW3wimNMxQ1HCAG89UFLsB
         nwxquwD6+nMTDYbqi2yYObCbEZDkIC0GVwe+7OaoATqLHb3bcvqPZWEB8X53JmeT8AEj
         EsoA==
X-Gm-Message-State: AOJu0YybLnfdWg8k+203xTYfrr8CeLqYYsWVIlvz16VLtyzr6Qeo8Fif
	AIdkY4wxlBrX5fLFV5mgg60u4Z3ylqRgvPJAnHuIaQwmGQxs7kbh9bva6SnGP4/w7vdNU9N310o
	NPul7SF5pC/nBUqtX/i9iV1fHlgaxhRp+HHLjL6Q=
X-Gm-Gg: ATEYQzz5h+bUf3vZ/cIWsQ+IHykGFCb8bYSueKy/n5XNQszJcBq03B+r22mp1vuOktj
	2/sY/hduS4bo+TWa1oAkGQ9pBoQvpHNz5nkGih8ocWDub/ceFXQB+l8EONJ5OIMSAY9i7Iw20zf
	6gq0EyInLtQhOYfe66yMscdLf4gxgw62z5zNmO4+jxx16GnLNZkFz5iyxFeJEie+TwnWv4HupiE
	EyxYmdQvC6KvYg8+/q5rnt6bmKXGtS/gTgGnJ/tRX0f+NBzCBEpXbTkSkLCefmcj71VwzPEpSv0
	jAjGY6M=
X-Received: by 2002:a17:907:c11:b0:b96:ef71:49f1 with SMTP id
 a640c23a62f3a-b97650f1896mr153299666b.15.1773391950940; Fri, 13 Mar 2026
 01:52:30 -0700 (PDT)
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
From: Sri Lasya Prathipati <lasyaprathipati@gmail.com>
Date: Fri, 13 Mar 2026 14:22:19 +0530
X-Gm-Features: AaiRm51lBikqmgVRx6iyZF0gBKip7rRgiamL2eJKzS4euqNcciaZDly33yfhspI
Message-ID: <CABDnCWkfX7jNZEcaCQhnJKw86WJijYVSrOov8DZSPDJT=S4F0w@mail.gmail.com>
Subject: [GSoC 2026] Introduction and Project Interest: Support generating
 filesystems from manifests
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2685-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,autogen.sh:url]
X-Rspamd-Queue-Id: 9FDE927FF84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: [GSoC 2026] Introduction and Project Interest: Support
generating filesystems from manifests

Body:

Hello EROFS Community,

My name is Lasya, and I am a 3rd-year Computer Science Engineering
student. I am writing to express my strong interest in the GSoC 2026
project: "Support generating filesystems from manifests."

I have spent the last few days familiarizing myself with the project's
goals and the erofs-utils codebase. I wanted to share my progress to
demonstrate my commitment to this task:

Development Environment: I have successfully configured a WSL2
(Ubuntu) environment and verified that I can compile the project from
source using autogen.sh and make. The local mkfs.erofs binary is
functional on my system.

Code Analysis: I have begun a deep dive into lib/tar.c. I am
specifically studying the tarerofs_parse_tar() function (line 700) to
understand how it iterates through the tar_header and maps metadata to
the erofs_inode structure. I see this as the primary template for the
manifest parser I intend to build.

Initial Research: I am currently comparing the "unix proto" and "BSD
mtree" formats. My goal is to design a manifest parser that is robust
enough to handle various metadata types (UIDs, GIDs, and permissions)
while remaining consistent with the existing importer logic in
erofs-utils.

I am highly motivated to contribute to EROFS and would welcome any
early feedback on whether there are specific manifest formats the
community prioritizes, or any architectural nuances I should keep in
mind while drafting my formal proposal.

Thank you for your time and for this opportunity.

Best regards,

Lasya

