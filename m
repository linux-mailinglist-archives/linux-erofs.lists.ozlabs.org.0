Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C741E5B26
	for <lists+linux-erofs@lfdr.de>; Thu, 28 May 2020 10:49:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XhGJ3nGSzDqXT
	for <lists+linux-erofs@lfdr.de>; Thu, 28 May 2020 18:49:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=gjVgOV6Z; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gjVgOV6Z; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XhG504lXzDqH4
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 May 2020 18:49:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590655766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=2pnC083V0pnYzb6yk8o50sOtDplBpj/ICt68p1h9nVg=;
 b=gjVgOV6Z6kELXXpc8QmJIiveJbXugVh2NO3L7YR8pDJFr9mKtPHG/B3VtukclW0U4s8fht
 AF01WYx81LYDrhFbAHupvGtAdJa2vN63dxyy6BMcfy/NmCV/52QW5Lm+ZIeQqpi3cxhMfF
 CGNQHJ8XG2/R/L61R4ei75nKw62jzW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590655766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=2pnC083V0pnYzb6yk8o50sOtDplBpj/ICt68p1h9nVg=;
 b=gjVgOV6Z6kELXXpc8QmJIiveJbXugVh2NO3L7YR8pDJFr9mKtPHG/B3VtukclW0U4s8fht
 AF01WYx81LYDrhFbAHupvGtAdJa2vN63dxyy6BMcfy/NmCV/52QW5Lm+ZIeQqpi3cxhMfF
 CGNQHJ8XG2/R/L61R4ei75nKw62jzW4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-XodfZtLoON-yaSBowe7K-g-1; Thu, 28 May 2020 04:49:24 -0400
X-MC-Unique: XodfZtLoON-yaSBowe7K-g-1
Received: by mail-pj1-f69.google.com with SMTP id o9so4777328pjw.8
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 May 2020 01:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2pnC083V0pnYzb6yk8o50sOtDplBpj/ICt68p1h9nVg=;
 b=ZvuqWFrpfeXzSKo9orVrZgzkWtW6zHdppYCtZhTHGaY+sjdOhWHpBtZwcWX6bAm+8F
 h8sjczHxsj51YbseryQmoj8AGJDWeoJqUJOELa+RRqlBzLiXg3eXOQep+cTYzgeS5lON
 y4DBktJpbUtCyz5z4X682qx/wReMebBGxrHUSVP57RXw3AgMenONzjuI+5ZJuNlAeTBh
 ksS+LqZ85M6GyuNCv4ex0h2BnF1e2SN3pl7dJJAAKpOsJNJ7eHKO2ud84UL0J+Jp2MqL
 rbpwYcDmpQMmlM0nRlrZf4s5vnUAxs+0c8RYouQp/MY2OGvHLGVAs1pMrE+jkwZG9wBN
 NLdA==
X-Gm-Message-State: AOAM531CeoGChCpudajH2GMPS9nY3A3laMK16t4zcDYGbC2+HfVeSizt
 yFeOq/iD4rMMxKoUNn9E6LqWGGifZoBxic84KMfhdYGnugV2M54Foj1jSsVR2rnfvzhKl1XS9M7
 eflUg5+4u6zdyT4l5rP57lbTG
X-Received: by 2002:a17:902:a502:: with SMTP id
 s2mr2517703plq.267.1590655762871; 
 Thu, 28 May 2020 01:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlfbw5cs5+wHYj6N0Z8vXHmqrSjF0itXJonVuBbXoOBY00ULWOzWT03Au0097wsdr6IHNWBA==
X-Received: by 2002:a17:902:a502:: with SMTP id
 s2mr2517681plq.267.1590655762531; 
 Thu, 28 May 2020 01:49:22 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q9sm4099712pff.62.2020.05.28.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:49:22 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: suppress false positive last_block warning
Date: Thu, 28 May 2020 04:48:44 -0400
Message-Id: <20200528084844.23359-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Andrew mentioned, some rare specific gcc versions could report
last_block uninitialized warning. Actually last_block doesn't need
to be uninitialized first from its implementation due to bio == NULL
condition. After a bio is allocated, last_block will be assigned
then.

The detailed analysis is in this thread [1]. So let's silence those
confusing gccs simply.

[1] https://lore.kernel.org/r/20200421072839.GA13867@hsiangkao-HP-ZHAN-66-Pro-G1

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fc3a8d8064f8..2812645b361e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -265,7 +265,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
  */
 static int erofs_raw_access_readpage(struct file *file, struct page *page)
 {
-	erofs_off_t last_block;
+	erofs_off_t uninitialized_var(last_block);
 	struct bio *bio;
 
 	trace_erofs_readpage(page, true);
@@ -285,7 +285,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 				      struct list_head *pages,
 				      unsigned int nr_pages)
 {
-	erofs_off_t last_block;
+	erofs_off_t uninitialized_var(last_block);
 	struct bio *bio = NULL;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 	struct page *page = list_last_entry(pages, struct page, lru);
-- 
2.18.1

