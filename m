Return-Path: <linux-erofs+bounces-3414-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DHJLHaqCmoK5gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3414-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CF5667E1
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnCZ44fNz3dRt;
	Mon, 18 May 2026 15:58:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083882;
	cv=none; b=gnjuoVzhJqv+kQD+12jqU9ipdrdP+sdLjogMKC/vHufLUIUbTMUFK817p0NvcIJqZPwvQRi68qQUHFLAPE9F5gyheWpj32ioFKEPhP03y1b+g8PkxxuxmoEQsoxBFKt2VcAoPaS6n17npAgPyElKlUCCSKr2pgO04jxEtZ/hTYfdkogsdyEmvq0Vt8U369sJVi+5Oaa8fV5qmoubKt7YkYXJVu5094Gtsc1yKyBv/38dFwPuGCqX4ddnFGRwKGXpqVzFfUQmgKdoYg/XxX5emAbYVWiPvFjj+RfhViHs3CA6ARnItZHAOghqmgUpm3qdAFLnCak7+KsyBDG2BLu11A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083882; c=relaxed/relaxed;
	bh=k9RkXZxEwl6o/7FfnLzHzC2L0aybsy/Nb+ZQf2WEYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS2vdnrOAfvvDpnmRK1OUGAzM5NyH1f9ESuXGRGd/ssUTZzXlYuuWPElCxjHA+h6rze/QsqDzRjYby03HwqXyZi2TgF5Ce51EbH7qJDFSiCTfIk8EkFEwEdm26MPU/wXps6XOVHQoTsVIJn7EC9HfY5M6cdwsWEW6frMuTjFnRZq6whGE9ro1JPb5thvKQK9RSKvfMrpj7nPMehyb2lkuTibOoklgKD5L1nKJbjt3PaSSS0/xj/AcYTbb3vxYJR9Fho7QSdUx8s4GqoyzW1fuoCP8qyp9V7YQ7HClrO2jjPibkz9MtqwRWdbHpAB1hbvkODmPV6M/0wFIbAB7kENfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=c7DLp5iU; dkim-atps=neutral; spf=pass (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=c7DLp5iU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnCY6h7hz3dRT
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 15:58:01 +1000 (AEST)
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de [46.114.109.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id ACC2541798;
	Mon, 18 May 2026 05:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779083877;
	bh=k9RkXZxEwl6o/7FfnLzHzC2L0aybsy/Nb+ZQf2WEYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=c7DLp5iUteiU+nG2ilDybCk2K+Ck9cM1f0fXomFdixRCKkPTwGNiVoI8nnhEm0Vkl
	 nGgmHY+uh7EAWWaeZ7EGJ6MDNDRhEk5s9BLjIoJiRMsDvofC8Kn2azdyVrN/S5+65+
	 UvwUdFCdEY6xhOEeY31rJGlBuOwUQNRS3uvzcwqcX2wF4ynGquRjgRYQtoPinoF1l2
	 8puT7oGOL1/hMKnP+ZB2HxAbLGCi/Hwwb/BXDEGyMwWr9fkI9R6kI/aWePy2uK+uP6
	 K1QHwYRAx/bPAT7i4ATI3WE8Kv74390u3YHA6SAngB+0C40FcqhuMPplQnAhR7VmIm
	 FivnAgQrVCyZlbPGPgdNoPSUFI8qIu4ziLZic1jHKbTShwfbaH58M1RJQWt/TsEHvq
	 +R+Hcblo5FSBktF746t70Rx9LqGUqfIC/hTPtUw+ew8raXN7+uDetGIQXXrWieaJxP
	 SVLZFcauU6QtSP7p/Eu3rgu2g7tdrUmaF8CiYFTQ6FiZsq4boqkdCQCn9+c4RkpHlU
	 bnN69mNkr/lTgUC1221o9Q3PUAGqXjIAyu7Pt3nqt5pqSdh446+zUWRkuJ46xl3D+u
	 cyipXYPkngoWDxIZN+mOZ5nhzYlgyvF/eKbipuxFu68NaUx2eg6vjVajPRKAw1vxyn
	 6jLQBIZdl2lifpl690qYy7PY=
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
Subject: [PATCH 8/9] test: env: allow optional date field in ls output assertion
Date: Mon, 18 May 2026 07:57:27 +0200
Message-ID: <20260518055728.178507-9-heinrich.schuchardt@canonical.com>
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
X-Rspamd-Queue-Id: 060CF5667E1
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
	TAGGED_FROM(0.00)[bounces-3414-lists,linux-erofs=lfdr.de];
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
when the filesystem sets FS_CAP_DATE (currently FAT and ext4).

Adjust the assert in test_env.py().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_env.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index f8713a59ba9..e9d502148bc 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -523,7 +523,7 @@ def test_env_ext4(state_test_env):
         assert 'Loading Environment from EXT4... OK' in response
 
         response = c.run_command('ext4ls host 0:0')
-        assert '8192   uboot.env' in response
+        assert(re.search('8192 .*uboot.env', ''.join(response)))
 
         response = c.run_command('env info')
         assert 'env_valid = valid' in response
-- 
2.53.0


