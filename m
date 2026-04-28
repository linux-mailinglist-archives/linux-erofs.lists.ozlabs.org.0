Return-Path: <linux-erofs+bounces-3364-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJBnG/Vh8GnDSQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3364-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Apr 2026 09:29:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B8C47EDF7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Apr 2026 09:29:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4XBn3s1xz2xld;
	Tue, 28 Apr 2026 17:29:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777361393;
	cv=none; b=n9gZ5dkmoAuxzYk4+rp3cNOnc2bEbf1HeB9ksp4kvPuYsVS0S6x1Z8pgYqdW3I9W8mFdltUo6MXmxwGIFTar/S0Fc2S7DexvLUQVesQSoz9/D7F6s6GPOpTnJbLTxhGG3+CRbeOSjDLkPZlQ8sAx9zQkOApcBpwqP9AVxteXMO7iGo4DpL59rHEBaia5Vxm7zQmUeTA6pO39fTAK6bFKY9TEG7wHjLs8qf5O3JOJO0UMgC1pyY31wCQm60YdiJ/FB4DgBxdeMcMWFlNxa9Bq9XWtdoxcfW2vM8Sr8glMBKQh/3qHLj13zAxD9Ag5yiSK2yDVJp84/lOkC/Jmw/uaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777361393; c=relaxed/relaxed;
	bh=7e5ZR4uyeEBbnr39YNz57npi3uySWbbJxaEkGaqcIp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z5mkbknBKCEoxZhpPawCUxZFeZRUrD4csx6mBM5cWuGI1PmemzGTArhhSAJrT+AVNg3kQuRn2Lvq5C3WARlTCheMH4up4BeUChfgR632lyZuNCDfb9jr5tmGVJsO/Df60mhYUu7uyt+amxwkEJ0R2Z1Rb7JUGTdmZhdBjNqwbl5g+YjNbUoqndZ+8VI4DPQ+x6HK5H0/Fhx834mV3VFxfBH4znh2K8Sl3xjUzvEo0nRZo1fj9BUUrQ3+nabqA791H5MvKYIDKQTPGJJPDjfu7errnL4JszCE7okW8DBs1T1DsxSxiD+IcpZW5okm2GIsqXQIR1xwPg9xthJUBsj0QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qRIzI5mx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qRIzI5mx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4XBl4BCvz2xYw
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Apr 2026 17:29:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777361385; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7e5ZR4uyeEBbnr39YNz57npi3uySWbbJxaEkGaqcIp8=;
	b=qRIzI5mxhhwc1BPxVvskhtYyj3lJ5HcYEDs65gqU2TmvX2FCk30u0sbfjIeEEwvyAfL3azWKGgx3nGXfQVaTV9ZQNgfy1jqaZbCYthrBQ9w9p+D8Iz+Iw+3NMzZp42HgxxYUJyVka8u3YCXClPhJwBFrGZtyUrFtiRKbhzeHlqY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X1tlCom_1777361384;
Received: from 30.221.131.100(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1tlCom_1777361384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 15:29:44 +0800
Message-ID: <f2afe93e-245c-4856-b277-634271f596a0@linux.alibaba.com>
Date: Tue, 28 Apr 2026 15:29:43 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: tar: fix fractional PAX mtime parsing
To: Vansh Choudhary <ch@vnsh.in>, linux-erofs@lists.ozlabs.org
References: <20260329173639.54997-1-ch@vnsh.in>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260329173639.54997-1-ch@vnsh.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 84B8C47EDF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3364-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

Hi Vansh,

On 2026/3/30 01:36, Vansh Choudhary wrote:
> The fractional part of PAX mtime values was parsed as a plain integer,
> so "123.5" ended up with 5ns instead of 500000000ns.
> 
> Scale the fractional part according to its decimal width before storing
> it as nanoseconds. Also normalize negative fractional timestamps and
> reject malformed mtime values with missing digits or trailing junk.
> 
> Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
> Signed-off-by: Vansh Choudhary <ch@vnsh.in>

I try to apply as below, does it look good to you?

Also as before, could you write a regression test for this?

Your patches are also scattered, could you collect them
all and resend them as a patchset if I'm still missing any?

Thanks,
Gao Xiang

 From 4cd618eaeebb7a5acf5e82074fb1c9d619995f72 Mon Sep 17 00:00:00 2001
From: Vansh Choudhary <ch@vnsh.in>
Date: Sun, 29 Mar 2026 17:36:39 +0000
Subject: [PATCH] erofs-utils: lib: tar: fix fractional PAX mtime parsing

The fractional part of PAX mtime values was parsed as a plain integer,
so "123.5" ended up with 5ns instead of 500000000ns.

Scale the fractional part according to its decimal width before storing
it as nanoseconds. Also normalize negative fractional timestamps and
reject malformed mtime values with missing digits or trailing junk.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
  include/erofs/defs.h |  9 +++++++++
  lib/tar.c            | 29 ++++++++++++++++++++++++++---
  2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 5724c2794ab0..9f3d0f9c35bc 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -387,6 +387,15 @@ unsigned long __roundup_pow_of_two(unsigned long n)
  #define __erofs_stringify_1(x...)	#x
  #define __erofs_stringify(x...)		__erofs_stringify_1(x)

+#define check_sub_overflow(a, b, d) ({		\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	__builtin_sub_overflow(__a, __b, __d);	\
+})
+
  #ifdef __cplusplus
  }
  #endif
diff --git a/lib/tar.c b/lib/tar.c
index 16e9c22fbdc8..3755c1f5450d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -2,6 +2,7 @@
  #include <unistd.h>
  #include <stdlib.h>
  #include <string.h>
+#include <limits.h>
  #include <sys/stat.h>
  #include "erofs/print.h"
  #include "erofs/diskbuf.h"
@@ -525,6 +526,9 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
  				eh->link = strdup(value);
  			} else if (!strncmp(kv, "mtime=",
  					sizeof("mtime=") - 1)) {
+				unsigned int ns = 0;
+				int digits = 0;
+
  				ret = sscanf(value, "%lld %n", &lln, &n);
  				if(ret < 1) {
  					ret = -EIO;
@@ -532,12 +536,31 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
  				}
  				eh->st.st_mtime = lln;
  				if (value[n] == '.') {
-					ret = sscanf(value + n + 1, "%d", &n);
-					if (ret < 1) {
+					while (value[n + 1] >= '0' &&
+					       value[n + 1] <= '9') {
+						if (digits < 9)
+							ns = ns * 10 + value[n + 1] - '0';
+						++digits;
+						++n;
+					}
+					if (!digits || value[n + 1] != '\0') {
  						ret = -EIO;
  						goto out;
  					}
-					ST_MTIM_NSEC_SET(&eh->st, n);
+					while (digits++ < 9)
+						ns *= 10;
+					if (ns && value[0] == '-') {
+						if (check_sub_overflow(eh->st.st_mtime, (time_t)1,
+								       &eh->st.st_mtime)) {
+							ret = -EIO;
+							goto out;
+						}
+						ns = 1000000000 - ns;
+					}
+					ST_MTIM_NSEC_SET(&eh->st, ns);
+				} else if (value[n] != '\0') {
+					ret = -EIO;
+					goto out;
  				} else {
  					ST_MTIM_NSEC_SET(&eh->st, 0);
  				}
--
2.43.5




