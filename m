Return-Path: <linux-erofs+bounces-3416-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PrYM3qqCmpE5gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3416-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 495155667EF
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnCb2J1pz3dSM;
	Mon, 18 May 2026 15:58:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083883;
	cv=none; b=l+xLB2Nb35qlsXFCuqOaHBcqNDgcAD+vTlmNzEWY8bITL5xVedl3oKRopp255RQVKhuvBr4Iq+QUflvDAWNYFNhHNXTiudCwby2M2rTBIN/MWcCSeiepXPjmLSTftVOD0zrQyrSJf05L56LYW/EWfAbbiEi+GaiB/Ya+UnReqOkL8yYBS5qcid9EO7oPSEut3hvU5TMmbakXspaYjbukLFxGct4wH5fLemntsx3Tyw7vKj4cb6dH5iHJLpqgHFudFe1XD6INhanfmsek5trJ5WmtizGC/4yetOf0j8drwvm8x6WlzTyLCVZlz2yb4+XGjYpZI/xnkpfqNXkR7XcMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083883; c=relaxed/relaxed;
	bh=fntPcACb4YppDNayz2V3bV811mS5D6YgIKWp8aOhliI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSC8NRJcfJZhPK+2QLWhj+o6S1eF1x27Oyx8e5Or4lCBJ2KDG/JEcrmhDWVTTbDt7QYyr3FF4tlsq2C78VdQEceMmbokp9Qn88nH4ucyQL59lAYzHNOCbjN5aqEHvANhhIXs3pvR2UHZ6CP9vRtY3LDKG7sVVtvbb5O/B9POnjqYhwIfV2M7cs3sghOjgzWsw2u2VQNWwg9TnZKLG4pL0mkVtHHAODrKpCpqrR9Uku3kSTm17PNFK1M9thC+3CWdKF0KF+yfZsl7ntlVFfLBINKFgrFeYCuLdidGKWeUzXaxaX9Db67rYm0ndDKyVecgfTMV+mG9bU9Bo3jbsgJHVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=JQen0dAn; dkim-atps=neutral; spf=pass (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=JQen0dAn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnCZ11Kxz3dRp
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 15:58:01 +1000 (AEST)
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de [46.114.109.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D0DEC41796;
	Mon, 18 May 2026 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779083876;
	bh=fntPcACb4YppDNayz2V3bV811mS5D6YgIKWp8aOhliI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=JQen0dAnXtTDPAXwuG7u7/TaICf0nLTtcprVG9fiPho3mYiYoKaQTElVPcuoV64lP
	 ZBkTsV5VQE3q9ASbcwBAwT5wSI5p/KPnKizimmzLza91LOnvmyHt6yvRVLM7HvxCWi
	 cLDCgxinPXH+6gdY6311UNEH4Nl66YBsMEgkVYU9CCD/vQZ7wn1N7PEgXcGGVO5f1a
	 Rj66OGBScpSCCSfkSib/nWnvjHasjIgaDmwtkN5FscRc9tdmQorcNGdmzK/pTSA4QC
	 1Nrl38wRQbLMB07WlLDnHcwIUkWaOyNjsTKqP0z9/noLho00Q9jlr8fgIo+wYbQgGg
	 5vkZJwKrk3FwKX3rnjHBgaJSRIu1AIvpUiRsdYzLoZzZk9QpbafQhu2x5bimicXpoL
	 nQXS5nBg1DEqpAWUB1Uqcj9d1c99LOs4v5F2G11tMex5D0zKVh6DI/enBonDodFuwp
	 8vcm8cM5H/Xnuvw2S45+VSA8TUl56H2Fbjfjf93ydmZq8Siu4HiEtcU0CspnRPyBgu
	 N4R0DgMtcHlDWXH8ACNZtRR4bNg8RSIxSPhhehvQO+GoIpDb2LV9V0iqwUthVQPu7y
	 Yerb4kBUcgpPKA2XSdxwhF3kPNzvarj+NSgU44vx/aq/M+AjF2ewqy9kRGR6J0UD6q
	 YFVRHqvjKW2sqaGJdeEPeWkk=
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
Subject: [PATCH 7/9] test: fs: allow optional date field in ls output assertion
Date: Mon, 18 May 2026 07:57:26 +0200
Message-ID: <20260518055728.178507-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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
X-Rspamd-Queue-Id: 495155667EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3416-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

fs_ls_generic() now prints a date between the file size and filename
when the filesystem sets FS_CAP_DATE (currently FAT and ext4).  The
two regex patterns in test_fs1 used ' *' (zero or more spaces) to
match between the size and filename; that no longer matches when a
date is present.

Change ' *' to ' .*' so the pattern matches both the old format
(size + spaces + name) and the new format (size + spaces + date + name).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_fs/test_basic.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index 88b163ce305..5f2af9e21d3 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -26,8 +26,8 @@ class TestFsBasic(object):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sls host 0:0' % fs_cmd_prefix])
-            assert(re.search('2621440000 *%s' % BIG_FILE, ''.join(output)))
-            assert(re.search('1048576 *%s' % SMALL_FILE, ''.join(output)))
+            assert(re.search('2621440000 .*%s' % BIG_FILE, ''.join(output)))
+            assert(re.search('1048576 .*%s' % SMALL_FILE, ''.join(output)))
 
         with ubman.log.section('Test Case 1b - ls (invalid dir)'):
             # In addition, test with a nonexistent directory to see if we crash.
-- 
2.53.0


