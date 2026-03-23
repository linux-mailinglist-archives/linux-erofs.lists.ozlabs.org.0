Return-Path: <linux-erofs+bounces-2938-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCAdGEi0wGkQKQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2938-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 04:32:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8D2EC393
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 04:32:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffJdG1BTMz2ySb;
	Mon, 23 Mar 2026 14:32:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774236738;
	cv=none; b=U2ZNMrSTnM7pnHhnYOYCyCHHYke6WV91A16Y91sKNX3KzqqR5Gz7558FM14yJ5Uql9BjT4jWtDquNw2Gi6T5S6mMZATwPqUFjfa8sPMc+zbOSLehtefpvpWDhJslsRtM17g9LGon0Wo6pRGNRbq2SRrXlEj/VYlpA5Tip2SNEOSNb2ZzUkyJh1lKdbdloWYe0Sgu7oyS7vf5f/Wmx2JOitQE6hoHRjGtGI77PtWW+3H/bYm+jmbRLOnO1bDU44mtVSsJ/qbtClvqyiaiKawiJ8vST9gpmZHHjpjEL+9rjXJ6RHmrgdVQ9Xt3wve0g4ccTewAIpRbR+BuBgHYEUvvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774236738; c=relaxed/relaxed;
	bh=uC4YULvUeZ+i+gzuoyETMUgAIh6q4l9QXIwxFFqOxK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7wGGBmVkWall5vcu3uS4fz9xPF+tbMta39d5zZ0R2klDE/O95PfEenzVu1hGGCqoT3JXKciU7WocSeTNIyCWSfE1EuocztyboqQwBCmEGF6P8rUQ2t69rC93Q2kx1SKOo8j2yP2128kiBT+UJkLQ6TXEeyUZrrgpZdpk5+RJean3EAq6eR5ykKcSe6WoaNxX14cWIMTLd90H+zvCaN8yhlIMVeb0zKQ+eoOTIAlfrgShkneyGEN3ugLbXgnFKtDa+WjBEeWyJXS3La2WmWEvBffyZ6YGa8q7A9+EcbjcCkA6hyKlbj0m1w2wQvKtE05yJ9w+rvjUDL6oz676xzP/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i/jTUJHN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i/jTUJHN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffJdC3gcgz2xd6
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 14:32:14 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c7412b07f22so2050899a12.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774236731; x=1774841531; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC4YULvUeZ+i+gzuoyETMUgAIh6q4l9QXIwxFFqOxK8=;
        b=i/jTUJHN9WsRrOgbuwjRlwmUTC/85H2H1iS17cIBXDfz7pPsy4izchww2VC8g7AZ+B
         193+5UtemRWS8huv0stgYgIUv2jVhOLCp5njAVJJnotyekLtnOfLcBhDAMnl2W1NDR01
         7p5G2ZfL1JIMEpl7vmjL88GJiXKey2rVDMqtZaOJScwtkS/P3H6BpAKh1j2dqDegTvZv
         STH+6MCKJyTYx3Je4tTbMa0N95ldotsnfHnWCCmAYF3pLWZYi7TcBf+wJTx+8o9rWa/6
         6H0ojcYhT/HvBTNazYnNuooKF0SrTxjI0O2lO5//C128K4lkbu4K9miX68W14UTo2zp9
         XPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774236731; x=1774841531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uC4YULvUeZ+i+gzuoyETMUgAIh6q4l9QXIwxFFqOxK8=;
        b=dRzJBsGppfKTBZkoTh0POuO9zlnFaQQYphXOFt3ZRwRPvLWDciX3CjYSbKxpepqstY
         RmLlnA3NSag5/3z1VzXuhsDXMiiymtP+1B1I7/gousztcaN62Lef0RY/hUodcw8MOLOM
         +p3iOuf9pJkr9qac3jul+BlBCCWl7RAxgtlrd3/qVwXlSSsUXBcHkHCx4Zy+vSKKOmCo
         O1LZ5nkWTnAAii8FpUtS2hawJLyfi14XoY1C66eragSnUsqyX1rnzZRzxWxwJ27g9MCC
         pITWvm+oy99DoYYm5mCcAt/NAKOJTnVQMkEZw50F/NRt/VCBruG2t5HXT7lx+wgYEb/C
         YyVg==
X-Gm-Message-State: AOJu0YxdZMxMfj8PpzfvoZG57rxrQFpIKvx12XwUOlwAKbFY3YcO7AC6
	v4XnDjKZ9+uvOJhph5foUPHMPvCRKFdh9WsJBP3Lxrpo9I682jjUPh+e
X-Gm-Gg: ATEYQzyqw8ALZMMVCGorv6VClmdAgNYt+cUmBbfsEOxOh5dpeC1MH9TFETfZJ3GkuWL
	1c9isrrScKdvpJqljvfLJDguoYav9mLMVrR8NPmNSVFIyvJdhD26ke8JJC7NUyLzGFwF8Dh3p+f
	tPheeswN+jk5d1rr2SBkG61/4YpEPOUTuudqI+ZdT1T1z6QG5nMZa8FJUqsWvQkwKp7CYhhz801
	4+rljHJC/99dpNgmOC+8qoI540FvpIdDD+FeIt5LemkAS7CSuL33zcmGcG7KjFDSX8n9v7zLPeW
	IPQSUOH+h8S2Cz1iDpac88DhSkTy0iRYgATB8NAEotDcZjBQpmwUOjGMG6iosIuWPLKvIzJghKN
	aEWejIa51hB52rP6OfVuNdnG1eObaqWqUAS0B850DI/hQBerrOFSsIFcJQXeJgvpJs3aYClcRgN
	lC4AqQHRHlWvi0LnsHQvBsS+SOXpm3CDGXgzAEkP8MJ4KM3650dn809+ix
X-Received: by 2002:a05:6a20:728e:b0:398:94eb:1bfd with SMTP id adf61e73a8af0-39bcf0e4683mr8406918637.10.1774236731229;
        Sun, 22 Mar 2026 20:32:11 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa58dcsm8864569b3a.11.2026.03.22.20.32.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 20:32:10 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: ch@vnsh.in
Cc: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: check symlink size before allocation
Date: Mon, 23 Mar 2026 09:02:04 +0530
Message-ID: <20260323033204.97472-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260321183638.43353-1-ch@vnsh.in>
References: <20260321183638.43353-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2938-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 40C8D2EC393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

This patch LGTM.

I manually verified this by compiling with `-O0 -g` on macOS (arm64)
and using lldb for fault injection. I stepped through
erofs_extract_symlink() and allowed erofs_verify_inode_data() to pass
with normal metadata. Right before the buffer allocation, I artificially
inflated inode->i_size to 0xffffffffffffffff (SIZE_MAX).

Without the patch, bypassing the OS read limits with this size causes
a predictable heap buffer overflow and an EXC_BAD_ACCESS crash. With
the patch applied, the bounds check successfully catches the malformed
size, gracefully bails out with -EOVERFLOW, and prevents the memory
corruption.

Tested-by: Nithurshen <nithurshen.dev@gmail.com>
Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>

