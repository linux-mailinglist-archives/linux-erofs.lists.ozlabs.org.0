Return-Path: <linux-erofs+bounces-2741-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLKdBQ7ht2mcWAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2741-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B36298428
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBkv6LVYz2y7r;
	Mon, 16 Mar 2026 21:52:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658375;
	cv=none; b=LYSCmUwojwYXKSGemnE6YVAp+DLID9c/B2ebb5zAARZUxm7k6r2mfwpk0CNIVmkNOosZ1bD+jvgCdEBTS348UZNbxG+0rS3FYLfwO0lpBPqETQp6acpyfCXMVtBtdX9tVFYrQCr7/WIrC0/qmgPKQo/slcb6jzqFqvZnAATbZrIZh6hWK/dEYHHm9+B1QARI0i8n2qIbwadOzyuGsMq8bbw6FE9POZCIORWo+8gMcX1qinqF20bx8EuTj4/BODHfHFY4tGtgHnoxMPiNWWRiXMKWLt+z0Wp+pMS3mPfJOJuZjXiciCm6ZNOtBbc1P7tS7KYHwgjRcrsDjixbkV1HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658375; c=relaxed/relaxed;
	bh=6QIWIPb3YifOus+fOMQvgaGJ4rna8+g+3r4WHFtA10E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWpsJ3dbf9dCBNUACJ3rjORBpcI60+/tfe+AhdOoyObZytfxGj2sE4kg/q7+DNe8ud3vCmNldmudjIju7v5894mLwAskFP+YjT0a31Az6ohZ3Mr1AUFT7wXp7NgWH7mI8LJHhP/b9+5AR4jRZA3FZm9HtdPgocZMOfsX/d2M485yOFAxiWJGs7ONFAZogzhxb7g5nXgBQSaRIrHPbINb7gqLPTBimpY7Jb/WZbELGMImQZs0J4bAOGejHDEWdlEBHMN/Aof+kCCYoAysKJXVYBFhnB4egCkY6UJ5kVOwWf4quuOusJ+2ZKXvjHCQP2E8tc7E5Ovtt56bvB0LuD8dqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iDhlDFTu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iDhlDFTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBkt2YGgz2xlm
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:52:53 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-359ff894f0dso1546008a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658370; x=1774263170; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QIWIPb3YifOus+fOMQvgaGJ4rna8+g+3r4WHFtA10E=;
        b=iDhlDFTuTvqs6/5j/CscHC4hHmkzeyvWM15I4hhjdpoopC9+dNmeIse5kZnTIqf48B
         BOdlptBy7MbZio4RtU5QrONW8pFwFuIOy/sYdpzWQ9O1AdFiTivjGUm9clEtMqT95xIK
         /3TZnBxbi3/Q2SSBY0Mk3pCcm2tMeuZaMrSf7Q11F7pTSPWWcS0xCcvL5eF0N4LoW5Sg
         uf0Ttmu/rXkGjO3HuRzNlXtUmOeZc1lFAPSt8gTjaEkZBbm81BhJykIE+9xqT5kFT84i
         EGF2vFQeyzj2Vaqgh3totNG409QbOS3sWhmyeUV4uHkwjIqz3mpmJBhRsLJn6FM/B0iS
         CPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658370; x=1774263170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QIWIPb3YifOus+fOMQvgaGJ4rna8+g+3r4WHFtA10E=;
        b=ds54oKVPGvdmjSF7hNt8Mpo2uxGiuoWyxd/PdyN1GaFGsfjW7jTzILk1aypPhBhLGF
         Fs6fLi3ObevJbI5TqNqC3zw9kxDSf5EJvDZnx8tBa5at8OvZ8Z/bDkO0bM30yZOvd8pM
         3SpPA9Ki2noHDJQse+w2KAY6L0FaVdSLW5TNqsvW1aUVdbelSrSeCzueNuaGwLcpHg4y
         4RlpeC5VmR0dPv4vbKmFZg+gdu66PKdorP4KCU3E6Vk/8CFc6lHX7jiXaH7Nrilo32yV
         iQHQpkMUaUmtud/ieVy/uqiORCmAYDxcPsO2NVuneq8ezSF+GB9JjDP6D4jlGh+PXHBN
         hfyw==
X-Gm-Message-State: AOJu0YzuiKRrgDSoVynq1EhEYs4xRN5YLYAzTPVTs3VgsLc2IwkRn7oc
	yetF4/2WRAcSVwG2hv38IcbPdscprTM2OkwRwPyvEObm6FDOnzwljfJ49TFrpU2KJJQ=
X-Gm-Gg: ATEYQzwzbBCW7cjCj63EC7APMDy5L6bHD4hq/3/DUJhD2/w9ufcDUHfnSLwXqdZzmOj
	j9xZXrAnX04ayhYWsOCm5W5m06I1nxnczHOPKPZN5edTXQTzRtC7XwxkMCrDo16EIQVn0gV1SjY
	7iOPFVabSY8rJabRRNsT3Yi5eKH8zyxM8d+B5WkZeKLWIjIC0h6toDChNRr/ft0R/9wlnKnJCOs
	5ApgrkIhvh4kUSToXlkRw/agjMYbxdEKHEk9uU0i0xtDYkaE1wqcbdd5e3Vty7JOdEirmJYnYZY
	TLFdLvEqsLtBrgCBoD6eLkADhaouY4seZO8+OmV+iX6Bh26YSpdX3rdLwRjYtZ5DLUmTK54d4ym
	cqmU1+QIWZNd/ZtjS+zSbgJ2uhmUxI51Kbnsla47JJCcq2UkRjJ9eRbokAY4euBdvJTVSM7MbOl
	4Rly2zLbGf1AVUl2c8q/AIzPg8m/mYiSLv+zBt6iEnQFWyxd65vgY=
X-Received: by 2002:a17:90b:4a91:b0:359:8256:19f9 with SMTP id 98e67ed59e1d1-35a21efac57mr11911313a91.15.1773658370407;
        Mon, 16 Mar 2026 03:52:50 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b94e8baf9sm1693569a91.13.2026.03.16.03.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:52:50 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2 0/2] erofs-utils: minor cleanups and enhancements
Date: Mon, 16 Mar 2026 16:22:38 +0530
Message-ID: <20260316105242.6894-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306085717.12776-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2741-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 67B36298428
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch series introduces two minor improvements to the erofs-utils 
tools. The first patch simplifies redundant logic in dump.erofs, 
and the second adds a warning for unsupported file types in fsck.erofs.

Changes since v1:
 - Rewrapped commit messages to 72 characters per line to comply with 
   project standards, as requested by Gao Xiang.

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


