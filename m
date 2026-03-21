Return-Path: <linux-erofs+bounces-2917-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAZvEvfBvmlRagMAu9opvQ
	(envelope-from <linux-erofs+bounces-2917-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 17:06:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9792B2E642F
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 17:06:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdPS14VQ6z2yZN;
	Sun, 22 Mar 2026 03:06:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774109169;
	cv=none; b=dyWEkijxXKs0JHhcvKuJDMbqd8xLWJ40PkNEljC7pjHW9Fql43v2OZ6jt9XgQTMY1hrSYuEoq376ZyPCpPj7LBABPttclnNZwz8aEJn2Cb1KaG6oN8G5vxsIGIRb4nfCxikrKTqIOikGxilw7309LEtkvKU6ooemQnLD4PGRwjX3yhg2aWW7Lgng8LLxFcoiCC/1m2M8zny9crQAqILLu1BoEXEP61MzaljqQqcos38bckjPT3ATErZAOEktTeh6rehf3QcHXLNIoEv4lbUEBtMpVLTfytWgYJgB2PXOSmcokbchH+p/l6Ki19cUZjxQz17v9Jw8QTgxWt5tF/POJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774109169; c=relaxed/relaxed;
	bh=qeE+HGeYGmoNXxSchfxqRjsPNaxXNTP5ZyHGzVYLLtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDqZta6tUz2FeXyDGv1StBTp5zYOplNNddT5i4kocgfKQBhOgIxCpPgLEBBr3qQIKTMjkxbT3XL6Df6Ru1m+bSuKKi4GIZZXmkBhNYhgASaOOq3V90hAVtEXYvyhTe0roxh1vEnWGljDT3LC3XGk9l4wFoLIhy7f6ONsYKPhbTxvceeH89MHuBg1JhjMMahL8qgQ8HKT+FlN0gF1O/CTQa2Z9CGsaiOE1kNXk8VwbVam9sVY9wSwDZDyxDmyL0nrvWHB9uMb0KHBKU+mbRp8ef4nbG+OXD8bmhS5YVMZ19GqrI7/+OGyJSktgE73YL1xNDhNTmzjGgB4G+aDjdt9rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TLwHGD43; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TLwHGD43;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdPRw0CTSz2yYq
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 03:06:03 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-829a9d08644so848910b3a.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774109161; x=1774713961; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeE+HGeYGmoNXxSchfxqRjsPNaxXNTP5ZyHGzVYLLtY=;
        b=TLwHGD43JIr3u5cvOhepkWpab8+3760SEY5dCNKPTaGFuOi9uQiD0aqJGm31v2yuDs
         2lsLO08RfkEP/mXWcIyqD21JAa0aRhKI7+xtV0XAse+W/xctJMe0j4DzOvggktR/jT/C
         ocO8RpTfFzox5bGPqUKHqgsTXy4oE0eK9OodlDkahYAe2a3kfM612yN6P6jk70R3IadV
         1T4YkIxUllBjw3AGUv0jEarAT/PygPJp5D1idJfNMWFukpAgBxKDAo3CcHowDJpcULdN
         PZoTalX7/QhMbpXpai+3tYBAplCQoldN/tVgoYIWM/86qqbBwm4xad8vfPewzfpopwIO
         VpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774109161; x=1774713961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeE+HGeYGmoNXxSchfxqRjsPNaxXNTP5ZyHGzVYLLtY=;
        b=jWsec/9l7E3zabuABbsz3utO69qcyNapvIjoNG3J/wl135CzehqFeQYg+yl90lIiOy
         my3ywpKGwLOnlGGl2cpZaH4SGLV0kPVDLSZc9Hv/WdM88atEUufvAvqbPqwIqvqUMHnU
         3W+lXNe7NJvVmQSAGWWGvMADwRYnfC760jWpxX+4pcT9aq5eVYDsa+pKC2ea9aaqDWib
         XIqkMDAPaBvUSSI7rWVPr2lRkBceVvQNY/YYblVRPF/UO8fdfM94W5gfEWkAz9eomrlA
         mB7NuZE5xBLj1QldZ6xGipPOVd3c3l63sWs7HD6K7A6qcZzwz5jrpyDtR6nYRwOlLslV
         nOgA==
X-Gm-Message-State: AOJu0YyAmsNtx5f9UucwKxe5X7/ZAaARj+aqa40EAuligRF/tIp/YY7l
	/JgxuWRkunUhPR0rv2464gebRz9YHl2dUZ4t4K8uBkWSWk9G//hLERI5
X-Gm-Gg: ATEYQzxOJHb1uccURZnL6Udob+OSsaaxtPNiVKYJSWJhEy3qaWvOPg7Bqf39FtgmTnO
	6U51UW27QP920lqqJuqKBPLlPJue6ookQWt2gwNarhKzFdTCdHeimQF1Bk1ITKLeMyB009MUKCv
	Gy0ealutHxjpSDO0ylrWE+4HG2AcRl4qHp7/GZlaJYqeP2wQQGh1Qk+TvYdJKkRMmXuRxjMl+ls
	MwfrPg0GyLKTJaJPDj4QVqPObuuxXzCICTLUJ4KNOEhzMYXNdU8KNI49EqPpZIf68a06OGcnkqk
	hoA58UIhhms7B9fjDDOQI+cXYAAUOWuaKDor/ZYs3QNW4GPpMMfc9kChncQlLrbBjndz2UH4Sdk
	lJGWhErLqgWbURLlNFo+fvuEP/sx/IjdlR390kxUHWfHOT+ov6sWTxG+Jo2JMfFCxU3T+WqDKAN
	Ckmf//QuCx/HpnOVF84A9pNl7SRaOqISX3IL5Q/VYx6vDGYyQ6btRQ700O
X-Received: by 2002:a05:6a00:300d:b0:7e8:4471:ae6d with SMTP id d2e1a72fcca58-82a8c3afd81mr5746917b3a.57.1774109160752;
        Sat, 21 Mar 2026 09:06:00 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c212ac8a2sm4789351b3a.17.2026.03.21.09.05.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 09:06:00 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: ch@vnsh.in
Cc: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: fix directory loop tracking
Date: Sat, 21 Mar 2026 21:35:51 +0530
Message-ID: <20260321160551.20683-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260321142852.35991-1-ch@vnsh.in>
References: <20260321142852.35991-1-ch@vnsh.in>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2917-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9792B2E642F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

This patch LGTM.

I tested the fix by compiling fsck with a debug trace and running
it against an image with a nested directory structure. I verified
that the recursion stack now correctly pushes the current directory's
NID (inode.nid) instead of inheriting the parent's NID, successfully
fixing the loop tracking logic.

Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
Tested-by: Nithurshen <nithurshen.dev@gmail.com>

