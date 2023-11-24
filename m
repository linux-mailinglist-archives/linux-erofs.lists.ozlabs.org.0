Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5197F6AE2
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 04:36:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RB3UAbvX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc0yQ4Nj6z3dJ5
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 14:36:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RB3UAbvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc0yC6HV9z3d9s
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 14:36:18 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-282fcf7eef9so1075009a91.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 19:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796972; x=1701401772; darn=lists.ozlabs.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGFbS2R4iN7EyhFoSRluoJ0emU8WaJipoXCym3fhSXw=;
        b=RB3UAbvXDY3DsOEebjVqKqWEhO+d8xsHZKs5XrL0/Ad2aiulAhstCimFRp1DVJHNHg
         pd2C1J28HQ6fFv0Pp1P32OsUC8ewxKPRN2j6dFBXqd/vx9lfh1FX+gXKTDIl4vdaH6s/
         T1VBihJSrsS1jTvV5KMv+d62qz0YobmMjnzD8dPvfD/9RwKsqepBwfrthk1kE5Nbro8L
         Io6Rv+g1yVBWBHBNSnZcGjvt5oXZqbX1fKXzZ2nSuIHZV7749y1GzIcbSP88Q4IdY9Bx
         1qjEF/SZJ/o2Oc4DF3i6feji/3L1QOtmAD3t+asSGgr/likecN+LNyU4Sb260a4sxk60
         Zefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796972; x=1701401772;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGFbS2R4iN7EyhFoSRluoJ0emU8WaJipoXCym3fhSXw=;
        b=cfRCoK/POwzmQs4B+PMTCDLcHiOp6N2pQUVs5kdnbiHZKgGrCHTj892/Fl30GF4d5u
         vp3TWZ4MXyX+fAQQ/xNxRvGvRA6n75HtBQ1F/82+HjnVCjUa5/Cv7fyFUskXiEkt2oAc
         3SSo+7inbo6qO68JKSKl9rsTB9pvWToB9/61PehHkNEz5FQo7own64OT63aqTq3LA6Hv
         dBa7HLbKUtw98NiOONZnh7wzNV/zpS6G3X6Ls7V/xtBG0KujTZ/ck82Chbpjk/nfUAgs
         m9WATuGje0myAd/1nkIbfIwYAUpd2nwUbebGSwS+tcrK07greeheCokJr0e5lWFSSvLL
         5SUw==
X-Gm-Message-State: AOJu0Yw+PcofB+sfQeKZsnJRSNY3klnNpVcexovZ70rzj1kiRpvTMpyX
	DTOh4aT2y2Y5VeL/8/O7diN5T2w2XMs=
X-Google-Smtp-Source: AGHT+IH0IRltJsIj7pb2HIhiC08i16gP8SMjbAVHCO7SRpQ0UydQwsM66DJVdPiejaBWWYbhPqRMDg==
X-Received: by 2002:a17:90b:1c8f:b0:280:3a0c:bf73 with SMTP id oo15-20020a17090b1c8f00b002803a0cbf73mr1447029pjb.26.1700796972390;
        Thu, 23 Nov 2023 19:36:12 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b001c3a8b135ebsm2084288plg.282.2023.11.23.19.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:36:12 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: tests: double-quote entries assignment in _check_xattrs
Date: Fri, 24 Nov 2023 11:35:42 +0800
Message-Id: <20231124033542.25977-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Otherwise, may cause below error:

./erofs/019: 353: local: include/erofs: bad variable name
FAIL: erofs/019

Additionally, adjust the `-type f` test before the `-printf` action to
avoid retrieving non-regular file names.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 tests/common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/common/rc b/tests/common/rc
index f234fdc..cdc72a9 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -350,7 +350,7 @@ _check_xattrs()
 {
 	local dir1="$1"
 	local dir2="$2"
-	local entries=`find $dir1 -mindepth 1 -printf '%P\n' -type f`
+	local entries="`find $dir1 -mindepth 1 -type f -printf '%P\n'`"
 
 	for entry in $entries; do
 		xattr1=`getfattr --absolute-names -d $dir1/$entry | tail -n+2`
-- 
2.17.1

