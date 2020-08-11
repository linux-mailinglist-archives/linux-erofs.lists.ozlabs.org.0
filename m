Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC972416CE
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Aug 2020 09:01:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQkJv2tdnzDqSV
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Aug 2020 17:01:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.61;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=g7Pg5x+T; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g7Pg5x+T; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQkJg71fKzDqS2
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Aug 2020 17:01:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597129278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=TEG2fDTMrT9CyNXx3j58WMIBzVoaSf9PoptkoEoE8fA=;
 b=g7Pg5x+TuAgbCuWvpUokLGFmn3VgVR8k549Kl5YTlSJjo+M4UNyCiQf//aTelo/bh44YNW
 lDkjo76uNo+iG7jwFbFjMlqCU3LG0M1AoATDOBcrxHAdop8NaOVylw3W9x6SP4BlTEHLPz
 qwJxNxiH1869hLbxaRmsMU22MKw1cfw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597129278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=TEG2fDTMrT9CyNXx3j58WMIBzVoaSf9PoptkoEoE8fA=;
 b=g7Pg5x+TuAgbCuWvpUokLGFmn3VgVR8k549Kl5YTlSJjo+M4UNyCiQf//aTelo/bh44YNW
 lDkjo76uNo+iG7jwFbFjMlqCU3LG0M1AoATDOBcrxHAdop8NaOVylw3W9x6SP4BlTEHLPz
 qwJxNxiH1869hLbxaRmsMU22MKw1cfw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-Q3Jo4tLFMV6SeaFZzQgfBA-1; Tue, 11 Aug 2020 03:01:14 -0400
X-MC-Unique: Q3Jo4tLFMV6SeaFZzQgfBA-1
Received: by mail-pj1-f71.google.com with SMTP id s4so1645796pjq.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Aug 2020 00:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TEG2fDTMrT9CyNXx3j58WMIBzVoaSf9PoptkoEoE8fA=;
 b=RpUGonIuawi/8viAfwNtbUw//Xuy8u68djA5VxMIrO4au2BO4KWwJuiPKhfJtcBn+5
 hJr/Etog+7j0FNIggnFJngKglPJh+ed6cUgF4tbXFD8SWAYY9bidzCtSj06enxF51W9R
 HleV9F9MHmuLpEzDiyMf8zuoQLzmSq5X0nS+2SrQv4Bboqzg6I+rQMycJjvk9DvqpBQZ
 lpE7VGku6R5uxxX3/AQWx2+9OmgwHmDmRL2ejT0XstxGYdOJaFomdfevvL8DV3x0GMUN
 kcKZ8YRYsLzXVG9V1WutPGVJbZzHCXFb3kVocp2WXCc/r910jupbRxazAACFbf5m5RDb
 lU8w==
X-Gm-Message-State: AOAM533WOfUD2XORqNiVNDKv4hX8TyOP79irIo0JvGkzD1XRLJQROmQ6
 FE6hhVqRyj9DI4Zs/eMrk5f6W8h61aahrRp0A3fDw1Atm54Bb3+4YEnhb7IywC+m1amFCjJCCAl
 IVAmqxrIXUDnX3bcfUoAyd5ci
X-Received: by 2002:a17:902:b417:: with SMTP id
 x23mr25968239plr.231.1597129273223; 
 Tue, 11 Aug 2020 00:01:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/PxAh0tVI6Za7raz5oYvg/ytWr1qauzk4b41fv1H/5Mxa/CRU1ZHv8AgkFi0j4qdCop3bmw==
X-Received: by 2002:a17:902:b417:: with SMTP id
 x23mr25968217plr.231.1597129272976; 
 Tue, 11 Aug 2020 00:01:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y19sm24098541pfn.77.2020.08.11.00.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 00:01:12 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] erofs: avoid duplicated permission check for "trusted." xattrs
Date: Tue, 11 Aug 2020 15:00:20 +0800
Message-Id: <20200811070020.6339-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Hongyu Jin <hongyu.jin@unisoc.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Don't recheck it since xattr_permission() already
checks CAP_SYS_ADMIN capability.

Just follow 5d3ce4f70172 ("f2fs: avoid duplicated permission check for "trusted." xattrs")

Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
[ Gao Xiang: since it could cause some complex Android overlay
  permission issue as well on android-5.4+, so it'd be better to
  backport to 5.4+ rather than pure cleanup on mainline. ]
Cc: <stable@vger.kernel.org> # 5.4+
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
related commit:
https://android-review.googlesource.com/c/kernel/common/+/1121623/6/fs/xattr.c#b284

 fs/erofs/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 87e437e7b34f..f86e3247febc 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -473,8 +473,6 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		break;
 	case EROFS_XATTR_INDEX_SECURITY:
 		break;
-- 
2.18.1

