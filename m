Return-Path: <linux-erofs+bounces-2935-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA+rJ7kUwGnMDQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2935-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 17:11:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7332E9F25
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 17:11:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ff1Wm01bPz2ySb;
	Mon, 23 Mar 2026 03:11:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::730" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774195891;
	cv=pass; b=MYly77hQnxv2sFciSnSWTQfvGMYu1RQBm1knVnJxf4eKG82akyo2xgn8SbFJ06y959XQUrV0cC8lqG9e4/O6AncoggKwAI3Tpl6tJxdCG1H7YIYUk66F2q/UWrKMUFnbCr36HGXKuABn+gKURrlsoT7FZi1S0hwgTbsROKqA5B1VLQ20L4fDZbEXK5EX9ugAEQmxHs+wWwVWjZjg116EU0e7JIPHlQqhTygb2dGsQItKKV5VgFOXlfnOEir+0zx0+FJMpGNWkcyCsybBjfwhCB2saeK+9nII1QagqXSrHDx12jzh0zMBT73EQzRut1LlK3VloCGsl4yZDOxA3rAkYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774195891; c=relaxed/relaxed;
	bh=Y5u/F++CjLpD+yAXOTy7FTgHxo1ellDGzAcbE3wsVew=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DpZJYpxXwBapbLW1TTNgcLdttoWqrJEqQTM/RPuQPK5SnDWcg15EDk1vb5I0k/89QiQ/M9Zwi13AJpoSurRYxbT39Plx5u/XjQmdjHYe97uGRv8AxqDRHX6/RoZhubGnl89mTFYmlCiaJ/K41Mtc5lyiwyPYeQ53ZcHEoKj8gTocKC/nSA9ZeOxQFbhFmZ6dYPtBhGqSYuKHygKgln3gqXMGcy3q3T9xtUDjejm8RZByEzUTGtFJ8zJr+aWzkV+0n9s49zq8+fhmd39UFSW/oeZvL4aBcs/knEJkL/uJDThJ51nINpDH6P6iB9pbwqUgErmJacvK7qfihCxJ8lmcCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hKZn/diA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hKZn/diA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ff1Wj5k9bz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 03:11:28 +1100 (AEDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-8cfd1cf1748so23635285a.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 09:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774195885; cv=none;
        d=google.com; s=arc-20240605;
        b=TvkO2OQE4HQxQnzR5ZGe/LLcJyxlSJvjVNhrW4b7F9XP6hYIM8AIiufcwpK4G4k9Mv
         JtncoLOMEBEuEYsufFGAJsqxhv6WsSPo8QwmjlorW3uD7qDdhdYtrP1X4sBz+LoLbt7z
         CRpycALZGas6Jhxr5qkG0Z3Mqt1kJ6MiUlN+gpwGp+zQ9VALtDSVar//O9/Q4NcucEI+
         XYcdWWXZMoGtVI83JrDraW68nTvrXLZu7PCMGXWAcropG5lIh9WKGM0xLsXSBqS/+qfA
         c7zvM5LH2bh2TvBZilguykj7MswAAfx7PIGotaEjviYy2l+Jfl0shwGoX4RN6HW4kekL
         0J/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y5u/F++CjLpD+yAXOTy7FTgHxo1ellDGzAcbE3wsVew=;
        fh=tgy8ocJrDyhVy8FyurvvbeftkKA4uRPg/aphVYb4x/I=;
        b=h9xufuUVEJ4OCALTN4AWc6uZEptRMzeHN8vl+NW2gNvyP+RwIPxvYu8n9Vyvgyw010
         cEcr1GvfOkUdO6+XpiFyBeGQAS/ItqjEZC53OihZoil/20ZHrn7t1iVNvahT0BEGZJlW
         cbw0acfooBFl3N3tNd4P4hn8xaWz66mQLeuX8NRpxxgeEse/kFaOJXHS2EeZh/MfNICV
         mJKaAc1k26gsfEK/Nm8jAYZiH8LCbjVkI8jP2tJ/ED8rR8vy9uUFcf28iXKbhzyu9d59
         bffZZp+enCh40tiU8VPL4MMTy+BZiB2hLGJsMh3KcZKbv5ec3X+PWlWVFYoXQNIfkHVB
         IDlQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774195885; x=1774800685; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y5u/F++CjLpD+yAXOTy7FTgHxo1ellDGzAcbE3wsVew=;
        b=hKZn/diA/Z8Rf1r/8Wwc65cdx4Z1goEZSLE3mYnyKx+PFx88AsU/5K30EZwq2OHkqB
         7d1XUhYCl+N/Hn4eiv9UOBF1e03rZRjGv7SNkKIKAGkBtP9M+EMoy8SYc5JB4j+Zgq1M
         ODbq2oe3Qj7Mxxr49rfk8QZgbmXW6GZFQZEmTBlLemIVFDMIelFxt6UkWa4zBsHQrjBp
         mO3hULA2vpSZGS9igFx6EqzrhrGvlx80qwZXP9mN2JD+GJCkt9YqqAVPP5J/IDncC3Xa
         KNK3c27L/bJ1hFVYxih8jweiyvgnp25XbRmd88SK0tjZ2peuOTJxMgRAy1c1OF3vK3Hd
         WwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774195885; x=1774800685;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5u/F++CjLpD+yAXOTy7FTgHxo1ellDGzAcbE3wsVew=;
        b=HSpnI51PV9MzktGZKA3sq3A2Q2Mr1ZoPHU7E5NqIB+AQVssBj9hrzPc/ACPngREzJm
         LMiyWNT5/A9HPw4ft5qpfB+zgJpKU5bFFQf4GFjw4Z8bcPZEPpAiLkuwG0SP9VESFguC
         B6NM7SiVWNuWUJvlKwfPb/q/q5mCnR4FnIE2FUmfXTq9xE7uBNQR3J881UEoooJJyVP0
         6jHm/LOZvfhYSIZtvv1ywAP3b2q3HrewNcL/rOc+D53yGpd3sTbREzlzfOkDRT28+hSS
         rm07hf6BDn1jvKwRfGRkmh7kqGAgbbE/wI/vOEffTf854k7Bf3CfqaimhnfqtjkL+KyG
         tguQ==
X-Gm-Message-State: AOJu0YxpKWlAvw2kVssX2mDn4TtT7VWKqFCPv//Sb1juR7LfjQDgwmrB
	YiNW+VOaaarYaGbRWilSmPtreNmiXXNwhpft3TXv+vK3rZMag7m8ED0lbwX2mCp/qtaqZb60VUt
	F4yYyIo1RkRkG0bNEk+9Uk+193WVwHyPKnLmKDXs=
X-Gm-Gg: ATEYQzwXj5MEGnvDiz/0m2TNLpDAwSZ/YFoyJruaGTn/8faby2JxtjWa49/GBTcsagv
	9DhIGTlISe2BnEBrA2GShLcs7tdAYVJOgra0wOvXtMkkW46jSaWmHaZJaZiV0hMevLZss0PEJSk
	W/z2dRW9y2R/PofaOF+8ukPku2gpkJXO85pOjMk2oEeEKmIJJ79K1LGWXAVP3R3tGFM3JJaL8hK
	lxdQ/AKYAovU6Ym+K+5S9r8taw7yDNqL/LLDHDXjHgaMLLnQwuAW2n1UCl5vedRX9UiGz0IXaa8
	wBdk9TIdnbhVrrFmbWPcXj1yVXT7znY4ytviGSmUSTz/dC/ggD7mbP9sls882rVfdGOUHpul4dP
	drUw=
X-Received: by 2002:a05:6214:c4c:b0:89c:40b3:1093 with SMTP id
 6a1803df08f44-89c85a28864mr117003756d6.3.1774195884697; Sun, 22 Mar 2026
 09:11:24 -0700 (PDT)
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
Date: Sun, 22 Mar 2026 21:41:15 +0530
X-Gm-Features: AQROBzBWkAyFYr_R_CCCL89zbRwWQ_YAoU4VyUL_1fDj9NtK-wr_R9BI_xOanfU
Message-ID: <CAGSu4WNBdB30K61xoUCi3FB9QR081fNh-1hoX1z2TZMk0nGpHQ@mail.gmail.com>
Subject: [RFC] fsck.erofs: multi-threaded data verification/extraction
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <yifan.yfzhao@foxmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foxmail.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-2935-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: BE7332E9F25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This RFC describes a design for multi-threaded verification/extraction
in fsck.erofs and asks for feedback before I send any code.

Problem
-------
fsck.erofs processes all inodes sequentially. When --extract is used
on a large compressed image, z_erofs_decompress() dominates CPU time
while other cores sit idle.

Why a naive per-inode thread fails
-----------------------------------
erofsfsck_dirent_iter() mutates a single global fsckcfg.extract_path[]
buffer in-place, advancing extract_pos on descent and restoring it on
return. Any two concurrent callbacks would corrupt each other's path
state. Additionally fsckcfg.corrupted, fsckcfg.physical_blocks, and
fsckcfg.logical_blocks are written without synchronisation.

Proposed two-phase design
--------------------------
Phase 1 (serial): Standard DFS walk, unchanged. mkdir(), symlink
creation, and hardlink table updates all happen here. For each regular
file, record (nid, strdup(path)) in a work list.

Phase 2 (parallel): lib/workqueue.c dispatches the work list. Each
worker carries a per-thread struct erofs_verify_ctx (raw/buffer
pointers) allocated via the on_start/on_exit TLS hooks already used
by mkfs. Workers call erofs_verify_inode_data() with their own ctx;
no buffer state is shared between threads. The workqueue is destroyed
after all jobs complete, ensuring all workers finish before exit.

I confirmed that erofs_map_blocks() and erofs_verify_xattr() in fsck
are already re-entrant: they use caller-local struct erofs_map_blocks
with its own erofs_buf. The only non-re-entrant state is in fsckcfg
and the hardlink table, both handled in Phase 1.

Shared state plan
------------------
  fsckcfg.corrupted      -->  __atomic_store_n()
  fsckcfg.physical_blocks  --> per-worker counter, merged at join
  fsckcfg.logical_blocks  -->  same
  erofsfsck_link_hashtable --> Phase 1 only, no locking needed
  fsckcfg.extract_path    -->   per-job strdup() at dispatch time

fd exhaustion: workers open() their own fd, use it, then close() it.
Maximum concurrent open fds equals nworkers (typically 4-16), not
the total file count.

Scope for v1
-------------
MT only activates when --extract is passed (check_decomp = true).
Without --extract the decode loop is skipped entirely and the default
path is completely unchanged. Directory creation, symlinks, hardlinks,
and packed inode verification remain serial.

Preparatory patch
------------------
I plan to send a small refactoring patch:

  fsck: make erofs_verify_inode_data() buffer ownership explicit

It moves raw/buffer ownership into a caller-owned struct
erofs_verify_ctx with no behaviour change. This is the only structural
prerequisite for the MT implementation.

Would appreciate feedback on the two-phase model and the shared-state
plan before I proceed.

Thanks,
Utkal Singh

