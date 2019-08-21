Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281896E25
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 02:19:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CpDk5YH6zDrFd
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 10:19:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=caitlynannefinn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y+y5p8B0"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CpDb4tx4zDqCW
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 10:18:51 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id f19so310803plr.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=57gZcRfgDGHX2fT3IVW27Y0VYhsGx0ciLsG0pvlDHNg=;
 b=Y+y5p8B0lzLHuW5kG8ttgFqeebFNxTZObxgwNZkCBWf+QQLk00bDixWY6RzBduTqFe
 edkSMEFNdGWiMeFMUGvE8Ae01qK/32fR2gRIRFVPzil18srA2XfLmQjEsfo8mzvUMVbA
 RL/7fcoiT827dXrb1ZWE6jpZ+ICelcQjWSlgt/twGBWHQp5Cl8AM1QMACZULkNzs57ED
 5xs/UTcKuYOkLDepi0uEoAzSc3ZgBU7E1IWpHOc+3KYCRw7OL4sY1yGjY8zlOahyLHS0
 7PdiWY1g4wEPPteK4PzrROEZ5K4ceX8WLZKAQhJgfIvYYIswBZXC7qYGmhxFijfxG4VM
 j8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=57gZcRfgDGHX2fT3IVW27Y0VYhsGx0ciLsG0pvlDHNg=;
 b=LrlIuJ56abWif2TbVSlGbSQPf7BX74JkY6wf+QziGN+13rnnF07ZMacoC+7SEf49+7
 8flRZvQmlIP01hHv5r0h6QQ2m52rhSB3ma6Rqi0wNDn1CsvzHkwD86TdIB5NQWzANnMg
 QQ4vpcZ+tBJ0fMgyZVcde8AxnDcg6+vNEq0u9yhgpRW9X3MPcSU4Cul8Ti0jhdDQP1hl
 Hgecsi0kiFZPT+W3XxtpJcZAn+pOFhWrsXNIhaASQ5piR127n6HJ/Tg5s3YAUILhyMYN
 6tOwzQnhXEiT1YnBRxPEYgoToCXTT9wEwHorcgkqYmWt7tbycqGtxwHnfmB8GBEUruz4
 JUKQ==
X-Gm-Message-State: APjAAAXmKzr3tGnwV4pSXojmC5a4hTX2cmrf7lnnRcPwYxsbtjD+E0E6
 q9DKXPjqvWgey7zyeGNC+5Y=
X-Google-Smtp-Source: APXvYqxQmbLxyDLbT0LkOLDX9rn36HoZ95N9Vdi5ziVyq4qecfy7S6EgpHIvECqUKI4WrFTEsbf1Iw==
X-Received: by 2002:a17:902:346:: with SMTP id
 64mr31089028pld.151.1566346729667; 
 Tue, 20 Aug 2019 17:18:49 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-188-36-2.sd.sd.cox.net.
 [184.188.36.2])
 by smtp.googlemail.com with ESMTPSA id g2sm18806323pfm.32.2019.08.20.17.18.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 20 Aug 2019 17:18:49 -0700 (PDT)
From: Caitlyn <caitlynannefinn@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] Submitting my first patch series (Checkpatch fixes)
Date: Tue, 20 Aug 2019 20:18:18 -0400
Message-Id: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org, "Tobin C . Harding" <me@tobin.cc>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Caitlyn <caitlynannefinn@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello!

This patch series cleans up some checkpatch fixes in erofs. The patches
include balancing conditional braces and fixing some indentation. No testing
done, all patches build and checkpath cleanly.

Caitlyn (2):
  staging/erofs/xattr.h: Fixed misaligned function arguments.
  staging/erofs: Balanced braces around a few conditional statements.

 drivers/staging/erofs/inode.c     |  4 ++--
 drivers/staging/erofs/unzip_vle.c | 12 ++++++------
 drivers/staging/erofs/xattr.h     |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.7.4

