Return-Path: <linux-erofs+bounces-3411-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIMsG2+qCmpE5gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3411-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:07 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D65667CC
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnCX47rwz3dRH;
	Mon, 18 May 2026 15:58:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083880;
	cv=none; b=Ne+TQTZnUOra+XUVgnoEDcULbNDPcE/Z/d/AMc5fxSKks6Lx7UyjIaq8rd7wirsl75t5zpA8EeyUqmG7PMRlHIuXgYsE58fvbyA+xJPxSfOQ98MXIjqmf/EhSSFsIcBkxzIKJMtRzH96TklEp47k+nUFwOTpyqFNulgFGc4uXqeVrG0/5zJCikBbXQ3zTvY1bzXwMfP1Yb/+Lh22VY3PXRMdxQcnqyymTgqRDDR1QHanoagq2xOtf5bHt8/wzLndyNq7fZAsxzMrHB9fsKB4MUcVLtBUoqLjKSl6Usl+ekPp9wHHbfvS+V/H6da1ROXN78QLs+qWMfodT8H355cMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083880; c=relaxed/relaxed;
	bh=OZCpZu/c2ag8M1KotSGygZRzDu6zm5Wmre3bZsCXr94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuZnSf1wWVKcT+Q97WqY6A6nXKNnlSpw2J5YiXK0A6uhG+yQsa/SyQ2CYfk5M3szWcWX3ZZj4YiE8SW1pxJLnLfeOcagqA480bQOJtCpnZFPy6gdpBMU4jF6kUsBMejSnxRYqo0vxvY4s30r3lls9e6QRqSIYaIh7Q8tDgmg+S1+9vyETEiO0d1quHuWqeM9Z4HdbpWTOH8sD3jGYQ0VnAak1wEFhpUBoTr7yI3S/l5LgoJWj8PIwD8E3gVfcN3KoLfqG+RkqNghe08yJPlYGHfG9JWCMvPbEbH0lD5lKAfMuZLWWUy9sbSnXevnv6PKltRTn5Cuz2IoqtlYV0RtDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=eW4qI1JP; dkim-atps=neutral; spf=pass (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=eW4qI1JP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnCS4p27z3dRR
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 15:57:54 +1000 (AEST)
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de [46.114.109.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F3DF440A19;
	Mon, 18 May 2026 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779083870;
	bh=OZCpZu/c2ag8M1KotSGygZRzDu6zm5Wmre3bZsCXr94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=eW4qI1JPnxllEZ3juCi/YoB84yR1JKObD9+X9b+sHs+5Q07vEPsP6mKYP5xEBHGZy
	 dxMxMm+OYx4WVWJBDrjPUOFQ3DkEW/+Z8g+XDIWHKNhypA7inRLI+E58zENrAu2H3l
	 hCT1yz5CaHD3ZRe1+ybz78GRBl6wDBLkj5Wyub9txKkbDKdSA9zwdUJ4qBFPppRYos
	 4ukjn5R0bHqmavZLJ49jcgaRX+57v3zvtjjU/tywjLMv8pAmaQ8Ein/eju/PIECtiB
	 7j5YvSui9ViGpzB4NSTjp8M7/Ypv7ztChvO2Vl4b2mi1RBgpIaQN+pqd+ZAovz5lly
	 kYM9arsQcs/5qKV95/xEEoqEzke7QetUxkD9cnsadqj6aY/Nt2x0BdBV7fwcQ6sFYE
	 wNaAplRj5Yh6+ZwGZlMX0pgbCFGL51OKbCd8jUtDD0sp/0d94ZghdQIfYcAwdMFkBK
	 UU9JDD3KtqTlbMRW/nN8NSPkrV/sS3y9xL05Mu6CLLBDv/N+uSCB7YODGX26ug/BWO
	 jIm75Kfeyh9G0/akc7c0BUNyk2EZiILYVur62qOjUe+v7iFhzum8j9MDFbsRrqiHuU
	 HZCQQkJAM+d5cHXn7GZ5SP4EnSClSFe3bEHQDt5FQmik7m1Oh/y1qNVsxxfdVpyZo/
	 z6PybPceYE+YN+tb4L94du6Q=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
	Huang Jianan <jnhuang95@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Tony Dinh <mibodhi@gmail.com>,
	=?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
	Francois Berder <fberder@outlook.fr>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	Sughosh Ganu <sughosh.ganu@arm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	u-boot@lists.denx.de,
	linux-erofs@lists.ozlabs.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/9] fs: add change date to ls output
Date: Mon, 18 May 2026 07:57:19 +0200
Message-ID: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 908D65667CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3411-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:heinrich.schuchardt@canonical.com,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org,canonical.com];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

The ls command currently only displays the size and name of files and
directories.

* Add the change date to the output on FAT and ext2/3/4.
* Use the actual date when updating the change date in ext2/3/4
  file-systems.

Heinrich Schuchardt (9):
  fs: move struct fstype_info definition to top of file
  fs: print change date in directory listing for FAT
  fs: ext4: print change date in directory listing
  fs: ext4: don't read time fields in XPL
  fs: ext4: set inode timestamps on write
  test: Probe RTC early in dm_test_host()
  test: fs: allow optional date field in ls output assertion
  test: env: allow optional date field in ls output assertion
  test: test_erofs: adjust expected ls output

 fs/ext4/ext4_write.c                |  41 ++++++++-
 fs/ext4/ext4fs.c                    |   8 +-
 fs/fat/fat.c                        |   2 +-
 fs/fs.c                             | 127 ++++++++++++++++++----------
 test/dm/host.c                      |  13 +++
 test/py/tests/test_env.py           |   2 +-
 test/py/tests/test_fs/test_basic.py |   4 +-
 test/py/tests/test_fs/test_erofs.py |   8 +-
 8 files changed, 146 insertions(+), 59 deletions(-)

-- 
2.53.0


