Return-Path: <linux-erofs+bounces-2728-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBhTHTS4t2mpUgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2728-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:58:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95134295EA2
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:58:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ6sr6Tsdz2xpn;
	Mon, 16 Mar 2026 18:58:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773647920;
	cv=none; b=KhxJIy/Gz0rJYVH0/yLQ9Nmf3wINC07fOtvQVAOi08DNt5rPhlmQfyXyidydIiCPggqllI9m0G9DbFU2Fz9aMjOoNXX/OM2AmVun+kmKrWjE+AlSvXY7HdsiwFhr/m3wEQRJPMsplD5CntGo9uJehumFw+a2G7XB8XBeLocvitI8P5DJ0lSADbAKPlu0rluW+TcioUMeJoIKFWS/hxGSKFEWsyiQyMozp1vpkqlvY0giuGQxVmE3+hVkNCIZTGGELgVu3oYn6YbAFNZGgsQXHGKn9N2U/46na2V3d7UjnR4eZs0TiiKQo+w4aMiZK/E3kEK7ZqONd9Yj+G/Tnsoncg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773647920; c=relaxed/relaxed;
	bh=uUhBIiVlgdGNoUw8yHKK0mcIFZuI3ACb8yLfM7JpTzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUXLsLYYXFEFOW4mrC1EbT2vb5EVwjt7Dof+bRnfLlfi++8qvCRPx4UoVmE5NuuBHf4u7sf4BbhSVC64Jp5/jDAc7l5iAOQ0aWrfXqAttI+YhseH1148A4JYAkq77KjOsI4seVmWgu4KBUnnlCY6PPWEft1hVhuNqtMd9ypBAZz9eimCd58VXRNv6FArIQh0H6BlGEqg1qVDb0l1QU2zTNpMeCDb6z5uXyCSb+yQlIGyBq2DKH0tq8+1plOSbqLR2+5rgm+tPczNVu1YOBb5fdu+l0qlEE9sfVCXLEx8dEWyZ+A+ZWRM5/CLYoakZGn9ZMx3OvIhgjvNEnhAkiybbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cQ8FpJPg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cQ8FpJPg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ6sq74wpz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 18:58:39 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2a8720818aeso3156855ad.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773647916; x=1774252716; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUhBIiVlgdGNoUw8yHKK0mcIFZuI3ACb8yLfM7JpTzs=;
        b=cQ8FpJPg3ogBZIG6uYGA4eGrEJZM41l+pHH3/V9dfxZsZXhU3hwSTXZaju2D1ah+JI
         ViZByEnK2tZBZzgNMqVCTudp67hG6B0LGDDALxRF4eGwNMHjVxTH4KkGt5RY/5Uf0SqI
         /djirfWKwjACEovhTt/6bOmnz7EJtTFoE2/XVuulLl2eqKd4g1E/CVAQXGHlsLgkGozI
         EobUAJaMpzw/LT8pjNcld+2cvEcZpS48wNMth4I8nLO3hfFO7YKj0j2xHo0W5yrzHup/
         pOpBGv6VhA63u3f8yf9rvkQUjfKEQ4u7ub8WrWalRfRh+DMcQuMs2XAaz9tHV5OKQLka
         GW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773647916; x=1774252716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUhBIiVlgdGNoUw8yHKK0mcIFZuI3ACb8yLfM7JpTzs=;
        b=oOeUm6ipKMMbn/CTeAUBMTpIzP/TuwDUil7IGQg8umfsAO1hC4QKuy9tivrH/pCzBU
         8+CPxUD1vRAdQw/v0QjJS4GMXi1AxlviJ4DYnTFwNeD4abgZv6Da5/lvzpTlPICADnux
         QZNnfSde1hThtrLzoBbmE4Dykuz7yHlmnrHW5d7NKe546Y0ArdvVYXNnzYZry1piHeDM
         F9HyCTACeEwMB5dGMKfpiyA8f27Qb6THENA6IhqAdy6NFDsNVwjJPTPQKK9SxTMIpSEb
         LOR8TZxKrKiPPOuJE1eeoAPM7NFnJpf1EWicqctSs6NSi0a0NumqTJEjcDMVhV0QTjWY
         mI8w==
X-Gm-Message-State: AOJu0Yx8J0LIVjyDWEjh4RsDOmEgHndmYmSsdyWuFG3qpJkVhj6Wgwzx
	lvN9fZ6tJOM3QQDoC14w0VtH/kssPP4maGdzBVQIeBrN9/bLkceuG0Cf/U4DG3tb
X-Gm-Gg: ATEYQzw9v0qJBFODtDY9/Y45+ntPnhRyVp6yHnpJZwlLdzsL8556ZEdUt7QstpN2Fnz
	Fs9p15b419W1IbbO5uYasv6OgtD+00hyAtMj+4E5voe9aFqyevDcDLVC2tpRfiKkoqxvpSQIJoX
	7AFN2+NVrYD0CzMIdtGbUlUcnx7XLw39PEvAP2iIKRp4YiylQEOOKo0gTsfwx2n6DdnXXkah5Vq
	r8eRnlMjWrG9Sn0rcu0nIjGRxCpVzCQ6fLnW9nZS8fgwIm1VNa+h9Z1brAM1Ay1lPmlaXP8Csl+
	W/LwBZUP8OcyMXLlNLr8JPeAvD4xk8L9r+KSo9Ugi/bw+yJ3C6ZCsNZG7QWHiS6438GjW/sQaVo
	gBfGz8LiLIqARrfLGBR3YgQheaZ/CCmGvvOaEMJe2z8wf2J/+ahNGUQ8kfJ+GL/GWRq/QBVrDlc
	Gnj++ASj1LTBa0CGRiAt6DV84WL9maMXl0T+A3aGAZSaE+4AZOyQhNB+ukHAm871Mr+6suwSck5
	bJAYZYp4AG8h0RSh7uGNs7sKiFcs/cfGtRv0g==
X-Received: by 2002:a17:903:2ed0:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2aeca793a50mr85839935ad.0.1773647916101;
        Mon, 16 Mar 2026 00:58:36 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed753sm124225025ad.45.2026.03.16.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:58:35 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v3 0/2] erofs-utils: lib/tar: fix PAX header parsing issues
Date: Mon, 16 Mar 2026 07:58:29 +0000
Message-ID: <20260316075831.35495-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:62d listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2728-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,gmail.com];
	NEURAL_HAM(-0.00)[-0.713];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 95134295EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These two patches fix input validation bugs in the PAX extended
header parser in lib/tar.c that can trigger crashes on malformed
or crafted tar archives.

Changes in v3:
  - Add base64-encoded reproducers to both commit messages

Changes in v2:
  - Fix mixed indentation in patch 2/2 (use tabs, not spaces)

Utkal Singh (2):
  erofs-utils: lib/tar: skip PAX entries with empty path
  erofs-utils: lib/tar: reject negative size= value in PAX header

 lib/tar.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.43.0


