Return-Path: <linux-erofs+bounces-3485-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPCtEZXQFGoUQgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3485-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2026 00:43:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8015CF0C3
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2026 00:43:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPWBQ55sjz2xR4;
	Tue, 26 May 2026 08:43:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779749006;
	cv=none; b=bpeng5+sYJFBF4SArHCnn24aidU7tdqjGEVJcTOY6HYxHMz3N8DLPumoplSG9BH1hiWMY49BD9l2j13jbD7hwx0SdhM/QHn8hNRUHAJBHBBFgq5p5InIcgbDhKej4O49ZpGjrLtBPk54X8yQKzbQQ8huBvTcBvAZE5Ysgpp6XW5EOJZ4ZYxRsB8nEsrVMeJMy2z0usyKqsiuXj2xp77mhyuSnppFm+kx9+O9czI7hGSj+cf2MbT93MWuZtBIOkINZgMDQ+RlcEn7suM9noJcoZmRqkabpxbasGUxahEw6dbb466db8nf3TeyAiDm5+zA6T7qnONHo1JozQxgEyOz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779749006; c=relaxed/relaxed;
	bh=pmmYs6o8MLyDMzK697G9Xx0ZbqyEl5ryb3A8tTZqvbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HFfGdw+hbAP56Ff98TsLqnaP9cNrHjzXgWiLjDFgahIc04KbbUDkZjpOw1M6RULl3zyCBgot8e2B52FNAXNEGPc3fK4lzCaD5mig9McTDQQVn6+c53PJml1bDkmrAcD9V4PEFjp/+YoIoF0Cwy5QL/jZ476G4KZRajEUWBwuve24JUMaBJ2EpJBh1PBNgnvMBNtltbKd2lKLnKj+bPigGr2GzCQBI0HsGG9K4DbqeCFaaOnMtyjl830JqcTgTiclGl8qrycf9y0FNY0N9sLLT9r3Gs5DaC9X6M3TpaROaR4JZvkAeNce/e84EQ98/GKnt+5R8e2zwVC2E6oXJuZXYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=B6r+3Tg/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=B6r+3Tg/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPWBP1MjRz2xQD
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2026 08:43:23 +1000 (AEST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-7e61da76fd9so1683004a34.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 25 May 2026 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779749000; x=1780353800; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmmYs6o8MLyDMzK697G9Xx0ZbqyEl5ryb3A8tTZqvbI=;
        b=B6r+3Tg/3oNT47QJxMDZW6o2CSNkibRIo1reNtvgFMcgDPdrobfMtSOGi/dYXWf76v
         ZotiSjHG/EvtURUo0zJ5EGcCSzCGop+Sm2AFjcI6GJ8lNGO83ERvtH17RT06kgQfHdJF
         72LVAlgH7ytKNC1wVY0eSwjdg54O3SLthHrmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779749000; x=1780353800;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmmYs6o8MLyDMzK697G9Xx0ZbqyEl5ryb3A8tTZqvbI=;
        b=b1GcSlS/ZokOv4VMsflsz+daYTJFd8+z4Z6FnuKR40Gw2sziJDlrN/UpSa8UlE5jgY
         Dzf46CN8lP/V5A4oiKXvtbZwFKeGnu+BeVAWqJ6/6FJ6JOC4U3xJsarrjiJbumXz4VP4
         x8j++jSysTRZmAaElbczD1HdAf511KLOSIfUhz68gDhifNw2Ea+Pn8YbR5gL4xkuNl7C
         R0LsH70lk1NcN4Ko9q5VKWuHz5iX33keV3iKYSDfqgfCAJb9R36IhaCeFhmTDKfSgUvH
         GzLidedrzNN9IVRQLbaKtlNYcrit0DRJfrHKMP/+t3ck1dIn1LjAo7I6g2OlZWCXBGHe
         bgAA==
X-Forwarded-Encrypted: i=1; AFNElJ/8/giii/1hnjgKfaMM+OIhPwul8+ZKAd0eMWeO7hy3BdHl642sFUvN9KuoE75nUzQACBGeo/T9jzJfmQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOlSCdyGCz6lFEPaTHYvqDdHWW+L979V3X+QWeQy5qZOmbxlw0
	V16dcOMy59l7FsYMEmZsf7Ptk/gfjcHmL+r2isRr3f56dtIU9rv5f4qxNwKzrFJXGZA=
X-Gm-Gg: Acq92OG+GodDTOzUuKIyedbg2/JVoPuo0JTROLj2DzoijM84lKf7oVffcFQLuV7w+xi
	jdOit0wS0WhJS8rbDA/JAH1LPXQJNaUi6FupagjgotjOhUwb2qCjCBwYZJhnMRp0T8u5YUHED3J
	H2kcCYMLymP5tYViFjZ2ICTzIAdx6IUu8W/KgRka2D8xuyoXxVbKaMwBJe44G3pLuVbNlYjoMuW
	wghQjWVtKKLzuBk+Cp92GJgUEGwVvnbrxkIm88B5gsKvLyC0BprI2V1gfvG6snXbK5VfrCGqphe
	OjiIC/RZK5SCUdW6fMO2aDfg6ezOqoQ/xgysBTreOUfM7oakiCiNl8T1/5qVqSCI3oQ/NTsqbTP
	gKMehrvfWK/ocOQlhfLFLhEMcf/hoZUQRhL1FT9b/PqQ7lsNxvx35lF7lb2wI2KIJvskRp/uT5F
	mJrKO+hl5GdYRSEgZm7NVXNZ579iLY/mUsyaJPkA/HwRNI+Wn5OnJTmj/7iVDbzKTaoMDGB2MJd
	iWhrHhKG2/YjtBJzTASGXSVtNUen9nSEET3xu1c6Gus
X-Received: by 2002:a05:6830:82fc:b0:7e1:cba6:9837 with SMTP id 46e09a7af769-7e5fed7ddd3mr9745641a34.6.1779748999641;
        Mon, 25 May 2026 15:43:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:43:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: Huang Jianan <jnhuang95@gmail.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
In-Reply-To: <20260511085857.3933053-1-aristo.chen@canonical.com>
References: <20260511085857.3933053-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 1/1] test: fs: Use shared generate_file from utils
Message-Id: <177974899874.3696278.287402852405420815.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:18 -0600
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[konsulko.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[konsulko.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3485-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:u-boot@lists.denx.de,m:aristo.chen@canonical.com,m:jnhuang95@gmail.com,m:joaomarcos.costa@bootlin.com,m:richard.genoud@bootlin.com,m:thomas.petazzoni@bootlin.com,m:miquel.raynal@bootlin.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[konsulko.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[trini@konsulko.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trini@konsulko.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1C8015CF0C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 11 May 2026 08:58:50 +0000, Aristo Chen wrote:

> test_fs/test_erofs.py and test_fs/test_squashfs/sqfs_common.py both
> defined a generate_file() helper that writes a file of a given size
> filled with 'x'. The two functions were functionally identical and
> differed only in parameter names and docstrings.
> 
> Move the helper into the existing test/py/utils.py module, which is
> the established home for generic test utilities (md5sum_file,
> PersistentRandomFile, attempt_to_open_file). Update both call sites
> to use it.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: fs: Use shared generate_file from utils
      commit: e9848e30bd88bf889ef74799dab6c2a2a0628890
-- 
Tom



