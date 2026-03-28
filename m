Return-Path: <linux-erofs+bounces-3057-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHdAHKgsx2nlTwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3057-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 02:19:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C3B34CDE5
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 02:19:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjKRm2W4Sz2yS4;
	Sat, 28 Mar 2026 12:19:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774660772;
	cv=none; b=E+fnx6B1cDYgBNJc0pbDQbZ7iZHi7dCbAA0flbYxRhmFSyb11jdt/s5zmy+B/yoXuItLQnPY9H5aNZk1dam0jTQNJCWrx6JwaEbCmtk2PVxjpdsw+b+I3ZlIPUYy4EKLL9ZDV9hxNb+mBM2NzKw7Bp+KDq8F6+b0btp1bvEJIX9RG3pADoS8Ks6atherV4G/ajTxjx66tbh4zYwlS0ndg1j9aOACLI31uQp44yCAVz9zRUc82CC0rROOSlfpsMEXdGV9q6l8xvmG/v7AtHffh06SVxxfo1DZu3aSf1I8+Ck7wmgeyBNxm5rKT6HfkVs0IHWCVzmW6gJBIF1X0AHH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774660772; c=relaxed/relaxed;
	bh=PQT33QBRrjpJOJqPbwwbiFKN+/9x0zvRf2rqkL0Gk00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXnQrIXCxGKdSEbl7hdsqeDqtMraGbTBCYs6/UiHPmVHG9FzO15qG3SyCBSLyJoQOz1mxp7oaOyV/TNhcxF6T9/+yIiWtU+nr5m9EZeRaoFJNq/hl/JpMfBITpDU9SjLFMjOXJbVhJIBEH1awND/1tA3/p8FOEhfiUz5dTs+tiTbkH3cwmzSDp/6wQ1KUq9tmerm7ZaXmFll9VTJy5+2mo+LbdmurWk8zu4AvPvjGsMa/nxH+ChhOGOmR75aPQxKEdM8Y+4WxRfSVeEu9AMb0arHtdYHLF1h8zbKUeKoF2HXBYorSBvz4YU/oLslrf2ScnSBV1mkchJdujtU/RfREw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GNKNgIeC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GNKNgIeC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjKRl2Lfqz2xPL
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 12:19:30 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ab077e3f32so12113095ad.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774660768; x=1775265568; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQT33QBRrjpJOJqPbwwbiFKN+/9x0zvRf2rqkL0Gk00=;
        b=GNKNgIeCjKdj1zHsLSYlxOLqh/NTjMHWk+ZBnZg8Q6JYuT6xzfvHLMjHrFq7xDDjhD
         VupvmwoxjzmVCFE/x3ZKRVxjiSB7aGslrU9wSDpb3fnMzRI85+Gi6V4L3bf7iqx1wSHk
         BNWZpX8518ZJ/n/smzdeuZU8Xc9OIqwNqda8/ODHvxKKcQfeHlP04R/nUSg8i6hIJZtW
         2iXTFDESk1hZb8qjhih4Mt+bhLu8lj73O0upsuqCDUjAv1NG7v2xSp1iIEuryhhc23oP
         88UGmz4rt2AmaxaHSj9xCuO/lzzDhLcIEaiwjr+dJ1PyNXxDz5ZLRfyiKURp0keHjihG
         mr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774660768; x=1775265568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQT33QBRrjpJOJqPbwwbiFKN+/9x0zvRf2rqkL0Gk00=;
        b=SqcF9IxXCmN6z+M/m1YKgcohoDABEzeDjxw4nq+UiBxwkBuMviLS6V5uvHJhiscgwi
         rx5sKDDRAC7Z68gJRof2jZ53NFU3kprjDWmhgev9NDNszlXqd+sNI3/Mu1muIpCJRPNw
         9R2rvH61eq2Q7d0wSvLkWRP46p5SC32cm1zxRSA81CKWWN61BZqwNE6GqlOrxSmGhbEE
         YCJ+qdDlB5D4vp2AkaV365aGs6UxzFA7HVIMdp183k5mB20ryd3MYPLJwoyLK7TIAQ05
         kLrEPVt1it7qz9lYXN23BZDAtC/ZynfKPKer6lDPqM47lvqfwVkUaeRqDFL5er8xDAOX
         /kpQ==
X-Gm-Message-State: AOJu0YwXXUkM2BruCZJ46F1nfKMgHXkjrT4/i0cJy75TLX7KxJiLYKfo
	dLwooNBxIzGVHgf/oL9iS5ciIt/IHVDC+YeLNgD0hIGXZfIQQDBtVvvIgzLbSUER
X-Gm-Gg: ATEYQzw9fdUP89+3ZwiePtqtFIZL/miTAetU+0oJQYs0qcuVw331xcwzra5wCvgUp85
	YGC7PEBuc3jKx5cQdESxuDu6eu4Iln9efBwVOoptfWMWMGUHEsr+py3lstBTTa5er9fE+1yHrmc
	tPA59cCPD0ZmZMQjWjMdnLIke3J8V3EwkO3tRKjnJuXG2DNSXGFvWePTejsMZyY9ruxEwHLsm/l
	Q8Bae2iPwYNMeAoVzG2+QpkhG/YLnXTaHoGobKlv+D7zK9Fv5VXD3b6V3zZZQL8+6reiVemp76g
	3udNgoZsMwst7X9TDpbCRfMFcWz3t4hjrirVDyrnm8l6o24bv7TLbNsfO6aQJ3boO7GOkSCujEd
	Fg01RfhnYOKQ9lSOO+FRAx1Hb8YNVjIrwebGFzHApREooni2W9yp/FL0M1gYIJIFZiTmo1lAf0u
	fW8FCtClpFS41jPgd9+gs04ZXMyW1up2taPOA6axaZjjzTvOmiktYRpSGX
X-Received: by 2002:a17:903:1a23:b0:2b0:3f7f:8115 with SMTP id d9443c01a7336-2b0cdcb7d34mr44899965ad.24.1774660767886;
        Fri, 27 Mar 2026 18:19:27 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266b92fsm6111455ad.23.2026.03.27.18.19.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Mar 2026 18:19:27 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: ch@vnsh.in
Cc: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: Re: [PATCH] erofs-utils: tar: fix multi-chunk metadata reads
Date: Sat, 28 Mar 2026 06:49:20 +0530
Message-ID: <20260328011920.86705-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326103254.32152-1-ch@vnsh.in>
References: <20260326103254.32152-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3057-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 15C3B34CDE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

The bug caused multi-chunk reads to overwrite the destination
buffer because the pointer did not advance. To verify the fix
was working correctly, we had to trigger a read larger than a
standard 512-byte tar block without hitting macOS path limits.

I generated a custom tarball using Python with a PAX header
containing an 800-character symlink target. This safely exceeded
the 512-byte chunk size to force a multi-chunk read.

Applied the patch to lib/tar.c and rebuilt erofs-utils.

Built an EROFS image from the tarball using mkfs.erofs.

Extracted the image using fsck.erofs and verified that the
extracted 800-character symlink was perfectly intact.

Without the patch, extraction failed entirely because the
symlink target was corrupted in memory. With the patch, the
pointer advanced correctly and the full string was preserved.

Tested-by: Nithurshen <nithurshen.dev@gmail.com>
Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>

