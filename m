Return-Path: <linux-erofs+bounces-2780-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AVxCdfeuGnDkgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2780-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:55:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B02A3D79
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:55:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfmM1D79z2yVP;
	Tue, 17 Mar 2026 15:55:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773723347;
	cv=none; b=U+hhVKWAdAX3XxLrhexpTpy8l7bYLYGXdOUhnBJI+f89k+XstJk7RQQzzUFv7s5uSeatkKF5qKTVe39YdCeyaN3XWj0wAOPYYvwdAU/JpXU1EAJ/O2R6q/aCxK/4EmcMgBUmbm4eAjbsJ6eDbqe7OO6ZnKm3BLBeTRcTo0Pfz7p0RbRQdDPfqj/eJC45CLNHRoLcqrYXz5dyNvhnVOTyK3CaD2lUMGVpMJmeu/r2XGQG8LqczI6U08bIeUo7HEsqZ4JkWxk8WKCajz8++nghsma4e9kW3T/G3wYUOO/3X1zb/TbxNV1KeBqkJ/842CA9UEV2jhPyPOKI7X2d7dw1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773723347; c=relaxed/relaxed;
	bh=yUxnPXR47J19jD+1eRZGEuHu918vxubZzAYwOrwyxf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsmzoP/1snxaCbDVEJbzcya9hPwu8E+KUUTrVezQXAtc5uZtyCzOkvXsAE1lhhrJZY5JpcJ+UyyHM3iq7p3ZOQn0TBxHVIwTmtrUbhwaYyt2/wgfYzd0M/0WATFApS+CsBNaclfhDdgjy1KVpKhK+Jiso9QK8O09tQvP/Mjx1D9v6JR+Owusu6g+12+Gn6uazR9mthcVLbAI5hDEbTPlMo+8bKft3C/uwWd9vUCvQWt0IHycOtyjH8d+Ryv82XGdCTG5Bh49QOlJztKGyqwGWixaSKxm43K99EphjFH+cpkC9Ph3cABlbbVO+8VlK24Kq8TEVlQvlBEtnG964Nm2fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mHDVfldB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mHDVfldB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfmL2lPWz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:55:45 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35a1275242bso340021a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773723343; x=1774328143; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUxnPXR47J19jD+1eRZGEuHu918vxubZzAYwOrwyxf0=;
        b=mHDVfldBZbNR8xZB0TrQ1xPycui1RY37Zy2tXqhrvRpOFuByV3XsHBL/3sn8xeyZLi
         V4OaFHsldw+jnTJYkr6pFss0yTLTn3L+HCETwkZji3A6cz/gJt3fu96uFPGlUzJjXdjW
         NYxo3wPu2Q1E6t0G9SIBrFY5AsMTnZ/4j7krMk9GNMSyN16fbJtroxBRDCoSUfkPCu+l
         AeL2STWGKSFn+NuALcgcdxUh4yV13452PEBymlxNkv/1NrtNqMYzf7DLe7WR9jtmg3Xv
         4iWVzZfU0sWdPwvtWATFMSoT4gdjLWLJCjQp46baJ28LeOOGpCI+XYJaveTPy44LyrER
         Y3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773723343; x=1774328143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUxnPXR47J19jD+1eRZGEuHu918vxubZzAYwOrwyxf0=;
        b=EyUor92+1OxO7uvWEWvE/X2Fx/AP1Ks4qw5v8D8Y5iOYgW0Y8a79kCECgJDhwB0pSS
         olemfSnvFcMB3wKFAy0lljpCFoOtFbea7I2OwlKFhy+WKgYoSSUKXjTAHsxtLYDHP3q4
         22hyzg0GsBr8mdzbDNf1y30RT1A7XYqOKJYYrBPqX+G2zROwC18OCJu0rHCoChUG4Qdv
         hFvUEWe7txFo3dC5o4Bu/6OtaDdq86hLoPhAS1LG2N3URkEc/8g/cS8CrcT8Tr37aZHH
         s4flB5X9S1XDz+8/RnYKiO/9wPc7SeqvvPzb8PDKuL2JmVl2aOsb+wYbIbLADvVGoA5w
         rALA==
X-Gm-Message-State: AOJu0YwhtrZy2cqdCYUAmV1f63fNIQcbtmga3qZlXA/9pk6hxGtqVY4H
	9b1Es5mDZhLCYth8EFmvZm2Bi1cUKmW9IC8DW0lEJCIVu1mWhCidAgPp9RTCOVgn
X-Gm-Gg: ATEYQzzJMwrS4dTgZEvyGsDy+E1RnS/+a3gjnr0SibXIDFg5xVdw+o1NRvetN54VFk3
	ocDzv1fORuUCSnPBWziP2m8hwg52/+DCHlh14jgLtwmyqdWG7xUfp9famU2MEQZhHbU0UyIp+a0
	9bFYEXCjchhaG8W0lzlb723x3/QOFYgfOCQ5oVOahrsHUn8GhQuEaauBjmNxtvvDmeyhgoRNu4P
	By3nZnhuI8ru/PUGWapRyzruL2yFl5XevuKiox4sv4wCJnawCBDiQ+KnjLb5JqjY3fiicl/66fs
	huQuXvhVyrZ4I63HIPPc+6/1VRJyH2c40D7dObzeMoanbinzqxMnzvYCdpnaBZR93P21/k528ig
	XO3HOAQUlrYD+rjejW7PlK21HlUsN9K0BfO4FN+6KgqUpKEvMWLpWkHWehXQFBvemQ9KP2ichIR
	r8l+Q1/Gjz54YaWW1QTj5P/L55X/gmGCcMHGBn029kJJQUVSlOQcHoj11logfXHK44pZ10ph+Xg
	4U1qcE7g/J3csKciqDfVJ3VYoytK5ggr4TlMw==
X-Received: by 2002:a17:90b:1e48:b0:359:3426:c603 with SMTP id 98e67ed59e1d1-35a220c95c2mr10013257a91.8.1773723343083;
        Mon, 16 Mar 2026 21:55:43 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada43329sm1424602a91.6.2026.03.16.21.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 21:55:42 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	singhutkal015@gmail.com
Subject: [PATCH v2 0/2] erofs-utils: lib: fix ZSTD decompression safety issues
Date: Tue, 17 Mar 2026 04:55:35 +0000
Message-ID: <20260317045537.9591-1-singhutkal015@gmail.com>
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
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:1034 listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2780-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.893];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 298B02A3D79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changes since v1:
- Added reproducer per maintainer request

This series fixes two issues in z_erofs_decompress_zstd() that can
be triggered by crafted EROFS filesystem images.

Patch 1/2 validates ZSTD frame content size against decodedlength.
Patch 2/2 fixes a missing error return on decompression length mismatch.

Utkal Singh (2):
  erofs-utils: lib: validate ZSTD frame content size in decompression
  erofs-utils: lib: return error on ZSTD decompression length mismatch

 lib/decompress.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.43.0


