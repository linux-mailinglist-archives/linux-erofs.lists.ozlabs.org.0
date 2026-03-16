Return-Path: <linux-erofs+bounces-2733-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FNJC8+7t2mpUgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2733-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:14:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63B29600B
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:14:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ7CZ0Xg6z2xln;
	Mon, 16 Mar 2026 19:14:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773648842;
	cv=none; b=l4DKuZ2RlK3d2ZJvp/Wvk1uvbil9ArM12luaUbS5QFMj3GBHGaO9LcuEvXb03Q/90pMQgvfHbWwCuPhA5KbOAHVELts7Mx3U2VQMDm7vY9TBTNH0kL479z5cfkGhuzM2u7URdAjMucawuziqsbUU0ckmbWMusvQMrkhZDaDZnRZc/c+wixOhFRd4VCZ++xFW/Bx5tTLBfCWU6ls3U+R65VxMu4RYz3QPysuivCgt5bXINPPZpaAf7k5tB9vluwE+igSVASUIR7K8ywrkqFUX+Y3EzAfcnPzxJkqNkZnDnaztrUxH8bQ4NXZhcWipucFjGu1DTm9BoF8DJ9viSKEuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773648842; c=relaxed/relaxed;
	bh=RuWZ32Zn/hohoUfQpHOWb4FLD2R5HoptPdeWcxkdx1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbDXFgx1Xos+OCcuU74nxlw0iQplLXFYM9qKGJmzszsr4HofNvIB5MUUaUk+y8YdnZdyJOACXBl0Bvx1P+TJp0G6p9gRg/2aa9uCr5lrEvusKDFbq6KI57FQJekotS/cgqyh+2j2GGPK6Mv1W/Lnp68wk2T7CkaTd9UrUYGegZfV5m6AK6TxzMhnRthqVgsZVQl0tyI6z3snx7Dcw6lIiHrb38NR51i4q25wjfc13/pWvkhU52z54tJ7fgpIQV8bCqn4lzzBkqwsNl3mQh9ih5UrZB8ToadpUgqn6lCUxrP/gQtHzqNtj9+dz36t5SLwdmgTPtzpHAKBebgBXbVOiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N6pTdXHe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N6pTdXHe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7CY13J6z2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 19:14:00 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35a277dcff6so99325a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773648838; x=1774253638; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuWZ32Zn/hohoUfQpHOWb4FLD2R5HoptPdeWcxkdx1E=;
        b=N6pTdXHecdfMiYPcHdPwTSp6aSNESyp7fnVxs+SU2VmtsfD3gSBYAOR/c78l373czr
         nQtHhjIa65ydw5s7zrsmaxBO1dMKytjM0QDizJVoSZvThCNtgFmcTTCfsbRcb29WRp/H
         YGDyg4Ekixbsb1y9e60q4DAHDugmtHI3Ww/KfTqIeLH59LYwYv30CETLkkFFQQNwQTGo
         FWNWJXW1FYz/hcozqUD8xZC1CrvG3tHrINC5p3P4qs8txOWaVbm4sejiWFcRadiXTySb
         5/k4JQo6Y5gFDYF+QnffML7KZe1MHE80mJUMBGkHLH/5nFjoPstB45l+7I3KpaJ0Xvfo
         9c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773648838; x=1774253638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuWZ32Zn/hohoUfQpHOWb4FLD2R5HoptPdeWcxkdx1E=;
        b=qdkvfgg7k8sKri/9VUR2zn/Ff90GPrmS/UhqAi5LcgKcowugYoe9DFeTGijlsOaHWa
         4zwFgNY4DkexPSReEdDnc2i41oStFzT3KuumepiDihvvNMlhrVQpbLoMX5yFthwa5snJ
         1SHTkmsfIgxZd2sDMNfaxCwXg58cDVNAPIIDjVC7dM0WQ6seGd9rfN6DSKsEWFM5b8ml
         rIH0fMlWX47EqGBdgHKF0gVGFy/3HtqDxxD8MNqV87BL4BZIgX2oz8cWSbx94ALPfE8Z
         e4nVvgQ2eWduwOvEAIH/4dD0GYR8QbVMFkMBMwv7r4iPKwu+VCVY2P7SiwmcGTQkHOzQ
         tL8g==
X-Gm-Message-State: AOJu0Yz/C358BoxpEEO7KVNqltQxYU9LJyAfaYsIsC6MDHxYlAk2gwQ0
	R7eIKs6eChXwjLg5riaUnf6nXn5mDNPnZi7tLmh+ksCazy50Qkjadq+R
X-Gm-Gg: ATEYQzy+Xk+9KlB8a/vt2OQMhSnwbJY6pfHGZ7hUfNPvDj1sdfvPWRhhC6nfUxASonw
	TfLiyoWW0/0HTjHmBfG9v+Yxz/bAVsdIUE/hMUkRFoByUpvP18gmOsw9XjHuSCtaEP2ygv/BVIP
	Kvdl0pmbDm78n2Fgwtcj/2z7FINBJB/j0T18G+SJpOUyd5Sc4fDpmyf3+EeA5jVz/EnJMGH9ARm
	cRpy6fF11uM+J7ozOwRRu4lhUMTgoxAY2N36PR2I5HLLTnCj+MjQi/TG3MixHut5SyVvt4hXLId
	X3iv9zgWbx1Ybp+yAXv20ryrCN2lnQvxPp+tgzLM9nJcxFa61W0k3k9pB0W8RzYEfgE+TsftOqC
	+rBtXpuuef7Cf8NoMCzs5Cr8mnMZKxRD5cmTmzlgDiB3m2SEXL7UjXjzAT9Jf9l+h8vpAd3HqDb
	+TWoY5Ye9F6js3hhM1Y2XDKGG767OoFVqKiZOacvw5ScsB1sRPJ7FwXMvZivkbv08YoocUsnd5i
	EaWeFGLprrWp784Jgt9jLRvPPbPETX2GOJ6
X-Received: by 2002:a17:90b:55ce:b0:35b:a94d:7ad2 with SMTP id 98e67ed59e1d1-35ba94d7d9emr173569a91.5.1773648838039;
        Mon, 16 Mar 2026 01:13:58 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e196fdsm15840801a91.2.2026.03.16.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 01:13:57 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib/tar: reject negative uid=/gid= values in PAX header
Date: Mon, 16 Mar 2026 08:12:43 +0000
Message-ID: <20260316081243.40931-1-singhutkal015@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2733-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ED63B29600B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

uid= and gid= values are parsed into a long long and then assigned
to st_uid/st_gid which are unsigned types. A negative PAX value
would silently wrap to a huge number, corrupting inode ownership.

Add the same negative-value guard already present for size= to
both uid= and gid= fields.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 6fa2cda..13e777a 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -559,6 +559,11 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 					ret = -EIO;
 					goto out;
 				}
+				if (lln < 0) {
+					erofs_err("invalid negative uid= in PAX header");
+					ret = -EINVAL;
+					goto out;
+				}
 				eh->st.st_uid = lln;
 				eh->use_uid = true;
 			} else if (!strncmp(kv, "gid=", sizeof("gid=") - 1)) {
@@ -567,6 +572,11 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 					ret = -EIO;
 					goto out;
 				}
+				if (lln < 0) {
+					erofs_err("invalid negative gid= in PAX header");
+					ret = -EINVAL;
+					goto out;
+				}
 				eh->st.st_gid = lln;
 				eh->use_gid = true;
 			} else if (!strncmp(kv, "SCHILY.xattr.",
-- 
2.43.0


