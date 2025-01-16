Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFAAA13580
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:37:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbpD6518z3c6n
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:37:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737016643;
	cv=none; b=Txk9hVq8gxPB9wkP+/UCiECxXwyP4F0MYnuuJ/lLpgIIgguM1c2jL2WBP1BcWmG0LaQSJsOpTvS3VdomxTWumetca1JL2SY+LaFgucaIK2WFWsQa5XvTBxSgJboDTVJ1gXWxnjCWvddyQ+xKqpVNTnSZttcON5uNisy1kP2mBooQVVWFW5p9Z+mBufECoDqdiJLTVHVaKbROrEJJmIxvoc8FGTCm+z6tM5kyM9Wl1SScUeVW5a7cAK+LRwgGvvJYYCtKkCnywwjx/rshZhgprozQ5UgmtdWsUTM9zNYii58pfe9KhIFODJbN5FdbUj1SD7Cw56XPotIB5gS9LkpA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737016643; c=relaxed/relaxed;
	bh=otpLROXolPbT7ec9YcvlHuENAhnyCwUjJEVlWqwt4N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B995OgZs1TgFMsZ7vfOY6aZ3oCSaMTCtnqaD1FaBJrnpiilRncN0qrtyS8P7EKrICz8EPbfcjdue98TvY2OPGsUdu8mbOyD4SGhilyotMc5i2ViVlAttM1tO0j5JDc6ZRjO9OyVYKn2OBLiGvAJuxyQv8HH7EgJzJ2rPqTnQ63vpVeT2Nlg7YY1qTjYWAF3XOZpXI9x0pvhExeU5+P+Z7ctG8+z+4FTKgtwPzzSxbpHt+5ufMhaSbr31ftfVsfStKLEdusw5fn11AHKlXcT7E2gDRB3OHdg7/G4YyDk9umd8M8supwu9gd9F62hXjEk5L22rrAtFwN5kVMISnux9FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=bM34JS1l; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=bM34JS1l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbp933Ncz2yvs
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:37:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737016581;
	bh=otpLROXolPbT7ec9YcvlHuENAhnyCwUjJEVlWqwt4N4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bM34JS1lLXuARpjOE3ZKTyXHzxy4TBe/R4V0IRfsFAEC+dQM6f+BJjT+lEhrXB7f5
	 CKbx9MlkzxJjoYGJcPD9w6YOskQmnsuDiBW6bwyTVDwOhRsBPyVprFg9V7OIToW3Bn
	 sFNuwTRLyeRMMm8k0fpqP3t1K1hQu0BlBDImF4OI=
X-QQ-mid: bizesmtp77t1737016563tkodmhws
X-QQ-Originating-IP: R22WAXSZ8O0Y1UIQD9n02oQYDOsIlwAmFRJoliXHzBA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 16:36:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7777656777610264926
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH v2] erofs(shrinker): return SHRINK_EMPTY if no objects to free
Date: Thu, 16 Jan 2025 16:33:02 +0800
Message-ID: <149E6E64B5B6B5E8+20250116083303.199817-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N+gRuBp2eEM11ecl6HkjBu8gTd/Q2IREtOHMw/14si4jhpmV8i4GtKwE
	axxVj8ANAxQWBSwNr35pT5FrxuF001cIKGWvS+qQsvKbLO0kmMb151fcMkQJmfFyUULl19A
	xnD1OCK93WPSY5Jb+pLwLx8cuSH3DGUddVwNwFaJkJ8+NWfHqwbU0n+d4xEmhSikYHjue2U
	KUnxHqTHv6rY53L9ACNlD0md+riFHb3ZjyV6Bu1FeLi6UYTD3vKixP3S9WZ15dUN+2qdGOG
	b1FsQh/pMijcn0X2UquHFHrWwvNfDMI9CWvxfZclN4PaS41SeQ7BbTg9xr/t7BXeg/pbCKx
	uhk/8wzHPLpgCK7l4GS0z9q98/MCBNjwKtuSjMQpyfFl3HOisXyWj4B4p4mH/Y7u5hCwT97
	0tqnGKYxMJMfP6o00tqWBbT3NvDnrXcDWbMpUw15o7lHIxfl5fjb2UspuidR9cO/EzV8OLW
	yG5URj52wqJE5cwTlz+f/oyLyXsktnXNf/w+gBlkYDFvx8Zs2bWDfV3gHgyLL3/FtQ8uA8P
	RRSY+lEohfDfa8gOdfhePLMyqP6eNeC3Lgj+oWxuWgY0CAGrx/wiFI7wiCJFOuX69dVzW/F
	m/X2LwrjZG2E/l+VpvfOeWsXyozEvFgi3VsJZMt2ZNmUbNBfHH3JYkRFFy1zjO56xkDbpAb
	aEwu6SVKSw5mfhkZsGxTYv/XsCrhEB0RvO8ZC/xfQwrbgfEJ0EZJUoj8C7m69eotA8w2wML
	CkpYFudghoS7kgQKQH5EgbTEmFdczDmO5F9EdSl0b61sq7ibVz01gDrYQnW0dEgLpJ4/F4l
	BiEy7w8zjuBRzyN/I19FLJMYReoqOspPO8xc3LZuunGfM9Ehdku+n5FsGTQYYLO799hOZI+
	o5pMKEFpQMT2OZPt6QJ3Xcx6Wq8eo2jjv8W5Uae9l6JONfFrYtinmRElxoa7WE398KutreI
	xEC1t0X2R8j//t3ZTkmCUtsfhLSMae8IxFG6LaIhGU9IBvjD8egoDCjNDH0LN2BtUg2aV37
	BzrOIQEg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, Chen Linxuan <chenlinxuan@uniontech.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Comments in file include/linux/shrinker.h says that
`count_objects` of `struct shrinker` should return SHRINK_EMPTY
when there are no objects to free.

> If there are no objects to free, it should return SHRINK_EMPTY,
> while 0 is returned in cases of the number of freeable items cannot
> be determined or shrinker should skip this cache for this time
> (e.g., their number is below shrinkable limit).

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/erofs/zutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 0dd65cefce33..83fbcab70a92 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -243,7 +243,7 @@ void erofs_shrinker_unregister(struct super_block *sb)
 static unsigned long erofs_shrink_count(struct shrinker *shrink,
 					struct shrink_control *sc)
 {
-	return atomic_long_read(&erofs_global_shrink_cnt);
+	return atomic_long_read(&erofs_global_shrink_cnt) ?: SHRINK_EMPTY;
 }
 
 static unsigned long erofs_shrink_scan(struct shrinker *shrink,
-- 
2.43.0

