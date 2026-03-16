Return-Path: <linux-erofs+bounces-2724-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPaEE3yot2lSUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2724-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:51:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74085295475
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:51:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ5NS6Pv5z2xpn;
	Mon, 16 Mar 2026 17:51:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773643896;
	cv=none; b=o3OnyFUzAgow0yi2kSxS7kA1iKSrbUGGsqqUfaxflOffCtBILzGdEmJt323gieVG1dEhXczFK+egiVTBLHdOH9J3DFmMcTYrwBXrk25pJxisiplG9UOtBYN2AziF4ZnS7mi3N2rLAvGsLHAzdRuzEngELS88qgr8Jjo9CHbk/UjGTuPDU2L0GdYfsezUyZ/k2Ag1P23ZQsU3jy8wehH8xc5gBg0fJwlDzj6TYSTt+AIVYOAvPuALY2IWMDvXJbE1D9U3VVJL73qi2GYw+9mbN0y2NGouVcDmcCQl1vQUauD5hzdVFCtzxD7JDD68yTW8NlqUecGMAgiOoxhTrW3L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773643896; c=relaxed/relaxed;
	bh=7jzPjSlqBxgxPqshqV2Bp+O82Rty3MdJd5ChLHS4yzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcyXmZCwAbzhv6Ykx1P9DjT1bAbmXbvOQ9UyhF9ZvItsTY0Y2p0aaCiCF6XqHsqQ9ehQjkFEfFWBqOM10sRiKwMbAG7/AEq5BXePXqa2qFXJfrrVm/Nl2X20MhYMswECNRGL654oxiNP6zWjJkbZUz24iI3yzBGXX6sk7N9qZUROyY7K/S+6FrWR7LLc1B7VAGPd4F7U1BrNFTamHNoY4hsTGUwThIIdK2Aru9H4HdVW0rDWVaaOJjWWyK8o+cOTtkGzQSh2MoLxh4da0OeXUjYX1vX1BR0a95vMFSVOwbrMr/efYLv9bssSJHgSSls0abopMe3zJDBEMpcZI+7DFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g1Dysg3h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g1Dysg3h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ5NS1nfhz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 17:51:36 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c632ca0c317so135864a12.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 23:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773643893; x=1774248693; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jzPjSlqBxgxPqshqV2Bp+O82Rty3MdJd5ChLHS4yzg=;
        b=g1Dysg3hjvSo9tx7SryqWmjZ1kWriFiVfrE6Qqop1Xvc7+YzqN7LuMaBFep9UNV+9j
         R0sGW0tirLNp3MJ/ybjAhqgWqe2qu2C3HmgP6HtfsDpN5NP0zKjs9vOef1WjUINL82Ti
         F5RIbLCm4Ujkv2SQjfAf5ek3aL+2weh78C5Fqa/df33azQbyh+8RKxuiwnbsRfDzwrZz
         ahh5Bn9nsUIF1InBoJqqmft+ybfRAcYDHac734JcLqXd9/u74+Uo6OkCCztJGcBGy9Vo
         QkclCtQhDbaPsOcnRHl3qnWL3TYD2t2mtrHaOw0pFLfqSMogYENkTz453UmFy2ixAAZk
         DfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643893; x=1774248693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jzPjSlqBxgxPqshqV2Bp+O82Rty3MdJd5ChLHS4yzg=;
        b=l1nHyvLoQ3TF/j20GqK8ADV/7nj2rkhDTwhSUIWSvDQSycaG4ei1Ad54JDB2ii9Tte
         gonc/Cq5/J7OBSTw8KkZ52D8MvjayxS4VtXdGI4TnKQjegZsIH8xmpkAhPEI9V9skEzw
         bMNTojR5tXEoVFMOPzfANw/16UiyAxsgiYzyDKcTf5gJ+JA3JTg7XBrn0OyewPsj6NQ3
         ZopfBS/xIVx1MyZ5DIXlH4NZ6hUEavCbiB4b0Qk0KVrbue8JLS4YZ4XkXXuJ5oOi4Qqy
         0vbSBn+AKDx3x2DgU0E+6ykxrPRi2DhzR0NjV1jQddNOmdyIPKwUOTm1+omo8vVciHMe
         N/fw==
X-Gm-Message-State: AOJu0YyJS0Fsz4M/m97yP139Lm6Q3hg7WDgVV+rOBxIe4XECnuPWla2R
	gyrVef2nJlijb1pGL1DEichj10K1B9gVLaNHooZ3xROBsuE1DtCVmaWX7GYqBP5n
X-Gm-Gg: ATEYQzyyaJ44aakmlLqeomeaImQfPITRCb/BSKsy4SFurD490z2ziXdvPCtzvuZYJ34
	RIYrr19rvSndBZ4Es1h2eh0PS/2XOiFabDftua8pjccSjHIKuF4oRx5Iv8H726QDmOVPxyikViK
	bLhyBbDlahfP5NLPGhji6NC0jy8Z6SzzGknJ3vURjs8LXRsa7KKiL8EPejy9y3FJ5qwHTFUrkT8
	h7EissXBAZ/w6vxx48ia2ItUfPmHszHk1dTRQI+ylHfozfM1dt8AGGjdMFqB6wXKGZ7UOm5J2uU
	oRkgJZijW39tpncSWEsaz2qM+8ao2X1K1PBQOoXpXOqDhuuBux2a3roXnrEvblOBKLxlATyUeKC
	z4/72KRAtAsCvIHAzuQ7lv9cVQh1PPCBCSOdeXHexcan19AsUcbn/XFuaNLBZNRpy+YXoW9NSuR
	6XvMKBokk2e8codpWdchNrqKUXO7odZc4MLKJEKfE6uzq/1no9+L3Tloq7A8fhKuTm799Uq+trg
	MwQ2AgoXoi8OwgPo4VcTu1zPN2YtA7nEgix8sDtXJK0+NQ=
X-Received: by 2002:a17:90b:5306:b0:35a:329:73c7 with SMTP id 98e67ed59e1d1-35a21e45101mr8194991a91.2.1773643893208;
        Sun, 15 Mar 2026 23:51:33 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73fc1774dfsm4218601a12.1.2026.03.15.23.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:51:32 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v2 2/2] erofs-utils: lib/tar: reject negative size= value in PAX header
Date: Mon, 16 Mar 2026 06:51:19 +0000
Message-ID: <20260316065119.21726-3-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316065119.21726-1-singhutkal015@gmail.com>
References: <20260316065119.21726-1-singhutkal015@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2724-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74085295475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PAX extended header size= field is parsed into a signed long
long but no check is made for negative values before assigning to
eh->st.st_size. A crafted PAX header with size=-1 passes the
existing format check, resulting in a negative file size that can
cause incorrect memory allocation and heap corruption in subsequent
read or seek operations.

Add an explicit check to reject negative size= values with -EINVAL.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index be86984..6fa2cda 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -546,6 +546,11 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 					ret = -EIO;
 					goto out;
 				}
+				if (lln < 0) {
+					erofs_err("invalid negative size= in PAX header");
+					ret = -EINVAL;
+					goto out;
+				}
 				eh->st.st_size = lln;
 				eh->use_size = true;
 			} else if (!strncmp(kv, "uid=", sizeof("uid=") - 1)) {
-- 
2.43.0


