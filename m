Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7882BC341
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 04:09:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdwH002LjzDqdn
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 14:09:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=duwTL0rA; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=duwTL0rA; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdwGq2KQ5zDqbc
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 14:08:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606014522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=bjOFi5FKgOSnFyxA6Adb1icB0ZzO71nzVBJEkr3Dvho=;
 b=duwTL0rA+EJZNeZ8A26NuBAYXUdtf8QjU5HUjmnn8cWiqYWK6R2qYjbqeU9qH6uQetSyUB
 zVvgqeoX/DlogELn9XvOi07Kam8td0QwTF6N3jb2i3mVv4CbW9RUqBzfGhL+yInNZclBEE
 KgvuJLqwAcofrGGqaOR42r8bnX1aXBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606014522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=bjOFi5FKgOSnFyxA6Adb1icB0ZzO71nzVBJEkr3Dvho=;
 b=duwTL0rA+EJZNeZ8A26NuBAYXUdtf8QjU5HUjmnn8cWiqYWK6R2qYjbqeU9qH6uQetSyUB
 zVvgqeoX/DlogELn9XvOi07Kam8td0QwTF6N3jb2i3mVv4CbW9RUqBzfGhL+yInNZclBEE
 KgvuJLqwAcofrGGqaOR42r8bnX1aXBE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-0ciDDN6jPjeLgmsakOmpHA-1; Sat, 21 Nov 2020 22:08:38 -0500
X-MC-Unique: 0ciDDN6jPjeLgmsakOmpHA-1
Received: by mail-pl1-f199.google.com with SMTP id n10so9135145plk.14
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 19:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bjOFi5FKgOSnFyxA6Adb1icB0ZzO71nzVBJEkr3Dvho=;
 b=i288gyv7dmYIYE+hwIoOqZd8XM86xfHHsTDedCOEd6dgFrGdEPhl9WXvY/kGbOhxjZ
 65H6mDqUt8CTcpxTBhPI6a9pkCbwJDPibz7QjmTf+adfHPND+dn2H1TD3flXH8KMg77D
 hNoKxbSjij1gMdBV8eLFQDEsypHim4i11zy5eHE8Cp1F0434wXEU3cTQdaFBEVM28756
 ETZ7n4ovYkq+Piw/Czkr5PMJZLG2HgBLdP2ZnDFzcgbynowjNVKGcXPqRRZXWhKppLC1
 84ccJ6qS5nheBwHuBK2LTafcI2vV2TCUhpqlxmBgZa0jSQRBj0rv86EKDBf8iCu1fqFQ
 P4Dg==
X-Gm-Message-State: AOAM530PGrMA4Sin3kmj4OKZkBeleuKJdChNbZAe2B5oqoY1B1+Wb16v
 gpZe4oWflNNg2s1irCfBRSsFxWFW/8i5yra5H3B2SwhHtLaJtM2q7F7+/xWb16aNTqtXkgCXhIh
 j4LSibRXYVduf0s0S9MqjJn0v
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr19955544plj.20.1606014516933; 
 Sat, 21 Nov 2020 19:08:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3Z1H7APA3qDLPNRo8ZGkl70bt8bHYxJFv6CH+wSTm2Y4kup5kY8OhzGd+Z1nO4V4s6LeKpA==
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr19955529plj.20.1606014516688; 
 Sat, 21 Nov 2020 19:08:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k25sm7907627pfi.42.2020.11.21.19.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2020 19:08:36 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] lib/lz4: explicitly support in-place decompression
Date: Sun, 22 Nov 2020 11:07:49 +0800
Message-Id: <20201122030749.2698994-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201121191024.2631523-1-hsiangkao@redhat.com>
References: <20201121191024.2631523-1-hsiangkao@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Nick Terrell <terrelln@fb.com>, Yann Collet <yann.collet.73@gmail.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LZ4 final literal copy could be overlapped when doing
in-place decompression, so it's unsafe to just use memcpy()
on an optimized memcpy approach but memmove() instead.

Upstream LZ4 has updated this years ago [1] (and the impact
is non-sensible [2] plus only a few bytes remain), this commit
just synchronizes LZ4 upstream code to the kernel side as well.

It can be observed as EROFS in-place decompression failure
on specific files when X86_FEATURE_ERMS is unsupported,
memcpy() optimization of commit 59daa706fbec ("x86, mem:
Optimize memcpy by avoiding memory false dependece") will
be enabled then.

Currently most modern x86-CPUs support ERMS, these CPUs just
use "rep movsb" approach so no problem at all. However, it can
still be verified with forcely disabling ERMS feature...

arch/x86/lib/memcpy_64.S:
        ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
-                     "jmp memcpy_erms", X86_FEATURE_ERMS
+                     "jmp memcpy_orig", X86_FEATURE_ERMS

We didn't observe any strange on arm64/arm/x86 platform before
since most memcpy() would behave in an increasing address order
("copy upwards" [3]) and it's the correct order of in-place
decompression but it really needs an update to memmove() for sure
considering it's an undefined behavior according to the standard
and some unique optimization already exists in the kernel.

[1] https://github.com/lz4/lz4/commit/33cb8518ac385835cc17be9a770b27b40cd0e15b
[2] https://github.com/lz4/lz4/pull/717#issuecomment-497818921
[3] https://sourceware.org/bugzilla/show_bug.cgi?id=12518
Cc: Yann Collet <yann.collet.73@gmail.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v1:
 - refine commit message;
 - Cc more people.

Hi Andrew,

Could you kindly consider picking this patch up, although
the impact is EROFS but it touchs in-kernel lz4 library
anyway...

Thanks,
Gao Xiang

 lib/lz4/lz4_decompress.c | 6 +++++-
 lib/lz4/lz4defs.h        | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 00cb0d0b73e1..8a7724a6ce2f 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -263,7 +263,11 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				}
 			}
 
-			LZ4_memcpy(op, ip, length);
+			/*
+			 * supports overlapping memory regions; only matters
+			 * for in-place decompression scenarios
+			 */
+			LZ4_memmove(op, ip, length);
 			ip += length;
 			op += length;
 
diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
index c91dd96ef629..673bd206aa98 100644
--- a/lib/lz4/lz4defs.h
+++ b/lib/lz4/lz4defs.h
@@ -146,6 +146,7 @@ static FORCE_INLINE void LZ4_writeLE16(void *memPtr, U16 value)
  * environments. This is needed when decompressing the Linux Kernel, for example.
  */
 #define LZ4_memcpy(dst, src, size) __builtin_memcpy(dst, src, size)
+#define LZ4_memmove(dst, src, size) __builtin_memmove(dst, src, size)
 
 static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
 {
-- 
2.18.4

