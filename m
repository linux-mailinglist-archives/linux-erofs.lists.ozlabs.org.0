Return-Path: <linux-erofs+bounces-3585-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZUNeC68sLWpkdgQAu9opvQ
	(envelope-from <linux-erofs+bounces-3585-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jun 2026 12:10:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1567E54A
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jun 2026 12:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FNGJ7plZ;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3585-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3585-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcsbF1cTwz2yMn;
	Sat, 13 Jun 2026 20:10:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781345449;
	cv=none; b=FO68aTbPoSQ1U4LVPQcd+dNlK6aiCjExuNj5XFs3jTBIlx0BNzMyNwaD3tw3f9gICWXwQd/XQNeSY04gSUX4j4vOaEYoYGhCqFWqJLt6aP2W+BSdc0q0+XB7ubMXU1AhehJde+q0HO+5vy8OYQxCiwFaJxpcCYmxgncaToZ6pKHA5U89oD/raCcpZXf0AM2d0R2nU96VS148V3xZHd8gFaCNFDeu9/y+PT6IWGXKW/oRKzPlLYgU/aIcm6mbD52WfHdK/QRm3iEzEXHOKoMVxErkEwQfnIuoXofO40OxniZsBStrFJZqU96zMoAnX3H/APjsbWdetSbQhvupS15YQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781345449; c=relaxed/relaxed;
	bh=beP3szSS+HT/yqXkmKfpiFpTp7bB9BpZzw0JborbfPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zaj4+R/ZrU+ApIeik4b1NxAP8Wb0Q4aC1cNOvatXJKdtCVWpum5bKL1QrozfqdSE2jykxUJEYeXa0tyS4a4cp3WYOrOguEazS/4ZjEi8bPOADYxfiLSAf2rQLRa3YKYxbo7z9fX/PShg5aviJwinLUwxhozgeyfxQXlKxyxurI92F+7PugvR/oG5hsqKsLfoYCNujVyRMZF6RWG8VpJ2bz35jcpcYaMKVs2dnAQKn21kUVyjQz2JPNpbgRc9WceFnHF376SyvUFsZM93URCREAGB089ghUNySYws+PWeu1Lt9SUgjVaNbg6pSN9laFcqfjmZAROEsG6+FeLcvGyA0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FNGJ7plZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcsbC23f8z2xqn
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Jun 2026 20:10:47 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8423f52af13so1433974b3a.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 13 Jun 2026 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781345445; x=1781950245; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beP3szSS+HT/yqXkmKfpiFpTp7bB9BpZzw0JborbfPw=;
        b=FNGJ7plZyG2TNv6FEk0aFLcL0ZZYUVdRDBcNPVwYhWmo7HsuP1rMfcDdAR5aEylQTZ
         Ng9ENsnsOKho1dysSnfp0Il/vN1iVNedtO7Cklu9ZXUwT0/LDlqwd8EwzokjEi3sPhEv
         z/zMRCNeLWeOYJUEI0Dnui3BNrdHfdySixhFvxDGEcg7CfFN/s+A5DWH4E8jjTaQtQe7
         xcmnHOTZN3w7EmGAL9CvPIOrpPBSESXUmvx6DyDa4E0s43gSE3Rexf3Nif+GLGINyqee
         u9GyA/4w9e053MInEKGfX2y3qeff9okqrSFtw3s0VHrxqDrrUSXEFuPilijQspHtKJ3S
         YNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781345445; x=1781950245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beP3szSS+HT/yqXkmKfpiFpTp7bB9BpZzw0JborbfPw=;
        b=gdhjbXhvV757VqEYPa6JCnmv3hIQ7bBq2lA7UpmFxgSD5r0czQ+dpygtE7tuf7OOWd
         norZ7FfH8N9R9iohyZ6PjzVCfX3pAM+He2QAJP/KXI3YQv7JFXsaVmCEQjyYoRP35lcQ
         gpm68i8vnjshfv5oZccME3XN43+E2Sxf8YRIfnrqgfAaXdB4EHA17w5vvtkpRDJicn8B
         4vNJglUH9HAgszBo17zg69WzY2jaWvuzVYYs7FTX5xcCPdSuWNGTJzsH1AzsHlWAGhQ7
         J4tHQQEE7b32n8BWtPUWFUkr4TEzIHoXbANP2soVEo8Q/TqxESds1pj7TNT1uF20rJb+
         I+1Q==
X-Gm-Message-State: AOJu0Yyj6dGVo/WFkB62XY4LArpoDVzD9rVsEU0aN04oZDyUYX/ROh8E
	XGwwvFk3qLNlg5A8te+PZWwMsTmImIstPHdJKEufspeBclbYkcTgtCU/
X-Gm-Gg: Acq92OG+udQj6OHyOaxg+CxpO/SgJk7yuiQ2WJM09X+wWRHhnHFibMRdf1OpbAADY31
	3fwpbrgtMNoevSjGDwmuKyug9KGqXyCIZZJGqYcNrjKTgCnwh7BBe4plLPUsfLB39TF3dYDGZYi
	LQ/arXZ2dWhOZU9+2leUVyg0A1971CfKUUQLCMdtDejW+4h/TYGw7PKkaqOTMAli7qlxlDk1Fbe
	IOAJPm364qO6VWHvct8JZ4aPoX2xjHffk/nyZJ/imbwcpOUHkH7CGBBea//dxGw2A4fpqEL1/YX
	NxiPdTQdfkr+O9mjP7eTVCxZJyd0tAH/DHSuLM2T325XjVn4ivHLiZmf/pfexl2cdFvP4JVxZyN
	2I86PsMVFhS92gjxaJLF52o10IBNwZcW+qMVHY54qVUia1h6u9H+QTwiWTc8EuIG75rLn8AxMrF
	NfYf6+nhz4jbJ2tZMNbR5cJOsUIaBLx0mRksLpCvydaPgpH3GL3HT6PYI=
X-Received: by 2002:a05:6a00:a210:b0:842:708f:39a6 with SMTP id d2e1a72fcca58-844e1962f2emr3456844b3a.10.1781345444619;
        Sat, 13 Jun 2026 03:10:44 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d3f9sm4111908b3a.41.2026.06.13.03.10.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 03:10:44 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	nithurshen.dev@gmail.com,
	xiang@kernel.org
Subject: Re: [PATCH v1] fsck.erofs: implement thread-safe global LRU metadata cache
Date: Sat, 13 Jun 2026 15:40:38 +0530
Message-ID: <20260613101038.86333-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <423c662c-e8b4-4802-b7bf-34abd71a82ae@linux.alibaba.com>
References: <423c662c-e8b4-4802-b7bf-34abd71a82ae@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3585-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:nithurshen.dev@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49E1567E54A

Hi Xiang,

What if rather than caching the raw metadata bytes, the userspace
cache will focus on caching the parsed structures (such as the
computed erofs_map_blocks mappings) to save the worker threads
from redundantly parsing chunk indexes and calculating offsets.

Can I replace this malloc-based raw buffer approach and focus v3
patch on an LRU cache for the parsed block mappings to reduce the
CPU overhead during the concurrent directory traversal?

Thanks,
Nithurshen

