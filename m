Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3B5473E9
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 12:45:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKvcC3Hstz3bsp
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 20:45:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bOBnz4yO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=sudipm.mukherjee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bOBnz4yO;
	dkim-atps=neutral
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKvc64B44z2xTc
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 20:45:09 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso2250594wms.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=a9ATP95JSYITDvtcZYgILfU969WEQUwCi9QMxQISlfw=;
        b=bOBnz4yOrLBIRe9lNqLmJJYNnTUBHYxgfPjC/Q+c+by0cC6DrcHXWzzXAAQKsWs5Xy
         7H5yh5q+cSCvj9FDMI2qYQwgyW+KWhJ5k4Zjat9u+hNJxzSFcF9q10k2J5+e+E3DNndL
         lCeqaymyirCu8HVKMhERgx6kH5f/6tDGJgbu3uYRTJve23lgY17J/z/qiWTHFjMWeJuc
         6jWKfE1WBzb6/qjzIx+YjukuvouZ/eHUhHYDqj4SV5vy3IZq76QEZ/fcBwqOS75Fi9ZM
         L8426YwsgzDm0cHOigB5uFuAKuHESYnbHqM+qoIfxha1dqjpYNU0dW0RZF4Cu4SJ8mUb
         LJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=a9ATP95JSYITDvtcZYgILfU969WEQUwCi9QMxQISlfw=;
        b=S3pg3zLcLVMicLqWf3OjBEElQbhTcBLkVUV4XdJDDT12nvzCkMstJ67IarUgYVDg+Z
         TRSHPLSzDCbO7OIS7pDlirzdaqnEiZ2JyIo7sT9ce22ieqgCcoVrT+mud73J1CJMFIWK
         A+h/xYZeI5/+d7EFoUlatj/8usRdSfF+yjgORId9EEQlkxRRri987jTk+qcQDIMyriQW
         ZNXUBg8hmA9KTYbJPT4ji2OeWOnBqDP9Pra0BHYWTj9+5k7w2JGQPW374Qo39vd4vGUU
         k0MPN5mT0g8OnxHM+Vls7/YWZi69U6q5Aee9Edt44obe0pwvisJj4qD+Ip708D9FbvzT
         j0ww==
X-Gm-Message-State: AOAM530JrCnjSCGpVoToeaAzGvYQ9x/efJy1BisD5AXpyG2nmRdXEbWf
	hKer80Cq564aRm6AhaW9gYA=
X-Google-Smtp-Source: ABdhPJxjfvo6XrtQ+Hcu7hnFyGXxQzXmb+60Sxx8moqSaXPRMMOx26YUKe+ROCWhkMhCSBz3y1N/cg==
X-Received: by 2002:a05:600c:4e8e:b0:39c:80ed:68ad with SMTP id f14-20020a05600c4e8e00b0039c80ed68admr4069701wmq.63.1654944305505;
        Sat, 11 Jun 2022 03:45:05 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b00397122e63b6sm2006978wmg.29.2022.06.11.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 03:45:05 -0700 (PDT)
Date: Sat, 11 Jun 2022 11:45:03 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqRyL2sIqQNDfky2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi All,

The latest mainline kernel branch fails to build for "arm allmodconfig",
"xtensa allmodconfig" and "csky allmodconfig" with the error:

In file included from ./include/linux/kernel.h:26,
                 from ./include/linux/crypto.h:16,
                 from ./include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'iter_xarray_get_pages':
./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
lib/iov_iter.c:1464:16: note: in expansion of macro 'min'
 1464 |         return min(nr * PAGE_SIZE - offset, maxsize);
      |                ^~~
lib/iov_iter.c: In function 'iter_xarray_get_pages_alloc':
./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
lib/iov_iter.c:1628:16: note: in expansion of macro 'min'
 1628 |         return min(nr * PAGE_SIZE - offset, maxsize);


git bisect pointed to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")

And, reverting it on top of mainline branch has fixed the build failure.

--
Regards
Sudip
