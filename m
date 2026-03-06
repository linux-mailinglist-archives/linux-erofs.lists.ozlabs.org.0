Return-Path: <linux-erofs+bounces-2528-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO/hOAKXqmnJUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2528-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 09:57:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48821D857
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 09:57:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS0fQ4pwWz3bnJ;
	Fri, 06 Mar 2026 19:57:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772787454;
	cv=none; b=ocKorX910y1nj7EKlu8FpUNBj0473I5B33VMcZpXgEDhQoRo6K32dMTOEneOtD6YF/X9HTY3/7LNe8IXPwu5KLM4JU6CpspRdQMGrh1YH5CvsDycP9n8CKw7DrLHFBgySVbX/pKi90QB0rvPGH6laXX9smU2p9v+Fdx5lZVDcUzLgxHS/r1yLxejDaydP4sutrJwVw/8XnDzFSUeyHZoa3bJt1eDGhDRNE/0V+yxAiuM2cJio6oAV5Wnbcg2HT37CIfFrd9coaYWARLAWzUAVoktZZtaKu4xYK65kwL4YaEC82W3R79rPXUijqkbxY6nyDQKfoWa2XW5okmTAGLqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772787454; c=relaxed/relaxed;
	bh=5Dpd/EZmDQHBHUl3rOIT0BaiR2r+0WoFbv6DbLlSQtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjdXrFhf1iMCYPJPYkLz/GiGSX22YehqwkjxgV4l5mHcL/HJp8NsUXVjCHCDhr+5BklFEkwwAcOXEJFjJz0yAvxQvZF45F2abB78gQqVaPbyw3v2cP5J9ec6AOPRdNaaAAcRPtEhTyaFQU9bS53JoXhht1qwFaJ0CzAnDCEweT8DfmTb63yZ8YDn1rWM+FTPqZPoHs212S3sP9dz3TQXGMYcqMivkdeblJOTNNIKC8bboMRk8vp4lRviWwobvEAWXUcbC8YVouQRCKaj4AWqgZUIaNWvPzmAcaYF0+sIn2ijaeyqSciO3sDCVSCoHjWlA8PpfxgOC1gpnKjJGBdvZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gd6AQ1fe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gd6AQ1fe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS0fN5Khrz30T9
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 19:57:31 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82990763921so1379847b3a.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 00:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772787444; x=1773392244; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Dpd/EZmDQHBHUl3rOIT0BaiR2r+0WoFbv6DbLlSQtE=;
        b=gd6AQ1fePVw1OKAfIM5I9SGCrIZuxRLbhcUbuSx3Bq3/eK5MqO6F6cr6MyE8h3VyAc
         F3nmkCAhYNn/Y1iVqb8uLXDXaNnSS/dhVZajpdWG9xsvD1Xqb/h4QfLVgzNOS9A+vgma
         fH6qWQ3hxIqWaadmbU32m+uPzlmRmpcFma/lMc/Qgk9V3s69KwjW2nWWXqvHOd6xEfux
         uGugwEQmeD1BcCcKZCl5DOBdXXUhqBnqW7MohNY3lVaO49AiQmHlS7ayvhdbzks8WTqv
         tS+mD9dAvasqze4XcJvXM1c4LmGcl4hmZ5uXSxsh4lzr6s6QPLceZUPlcK4hvV7XfBPJ
         dIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772787444; x=1773392244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dpd/EZmDQHBHUl3rOIT0BaiR2r+0WoFbv6DbLlSQtE=;
        b=H3gLbQhIekkrSA7BwfU1GBhNt8aua5YpIcTvqLAS1FvE3d9LI1Eh8iNcvR0a9cB2rh
         tiNod89vpiQozAl5A63U6ItP0JuOku9NpfOnpETPr2AvzrspYKJegELHk9yIJQZE5s3h
         Q89JnY6xveXOpcdB6Ckv71uDstP4kgWm4Dza7+oLUDvxzEyYARGRvt+kJWVIm1iLz8UV
         vgxJjYJDKsp7DA3OCnVSZk878vBKtCvOO+V4AhTv+K1BkTLMuyIXVaZqLBFLajm3eEA3
         Eb460glhLKKLTsuBFi9R2/R7hBXLgRJ9xPJY3QndsJtZMGp3PK/71k0XJ2Z2Z2Z9EeDA
         k3mA==
X-Gm-Message-State: AOJu0Yw635Ci5qXE4YUBEKxNo7WhEVCD8+1lrtHrvNHjX0dpRxAdx/6e
	inxPJchwsOvDFY2Crgq+larUzlMEa4bAmVOoKTOiejP/egt50yi5zFtds4nl6/zK
X-Gm-Gg: ATEYQzxrdnZ0oKpPuPIv/KDbvtKWle7KCOdmK6U/mvc7gfWELK0s8iuBUgU4tAKcrZK
	S+pGFBM7ADX2eI2LSvKtNPTVCFAzT2Fx5+gpt7lwb4beYjxyHoKJ90O+QJKF+tWG44tVCAOwsZR
	Aci6lCwNgEptveEMAYlCsUcSePxdbLFk9Qy95zzQult3LMG7LVKpiPdHiwU7rAaDhODNDxL6drz
	6+FYS9G4KILLLq6OEEOcTEHwGzlhhK1zEdXrF97u+1cO+R7/YkO5+ERaONm6v1FJ5r50Q9zmwFz
	0wNPPQ0az9gx3S/bGCceClRozKaFWbIZsahgcUJyOTjSJgvE2hNaqPhAjXOnb0bHQ/aICz18+4y
	HMGKA0Ujg5dE6J1nHKpsNMBrHGg2/8zLhJ2dQNxvyh5n3TNlewr0DiDKUWPS7QNLeQpO63Jb2mQ
	OQ3Ywl/lT/JiubmdzQpI9FpAoDLIo0A6Mf0HAJ
X-Received: by 2002:a05:6a00:7483:b0:829:710d:a46b with SMTP id d2e1a72fcca58-829a2f7b48emr1211263b3a.41.1772787444334;
        Fri, 06 Mar 2026 00:57:24 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b406csm1175294b3a.53.2026.03.06.00.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:57:24 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 0/2] erofs-utils: minor cleanups and enhancements
Date: Fri,  6 Mar 2026 14:27:15 +0530
Message-ID: <20260306085717.12776-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 9E48821D857
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2528-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi,

This patch series introduces two minor improvements to the erofs-utils tools:

1. dump.erofs: Removes a redundant conditional branch in the filesize distribution output logic to clean up the code.
2. fsck.erofs: Adds a warning message when encountering an unsupported file type during extraction, rather than silently skipping it.

Thanks,
Nithurshen

Nithurshen (2):
  erofs-utils: dump: remove redundant conditional branch in filesize
    distribution
  erofs-utils: fsck: add warning for unsupported file types during
    extraction

 dump/main.c | 3 ---
 fsck/main.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.51.0


