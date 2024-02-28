Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9D86B030
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 14:23:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlFRS1yQ3z3vd4
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 00:23:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlFQy5Flrz3vXk
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 00:23:04 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 39E6C1008C721;
	Wed, 28 Feb 2024 21:22:52 +0800 (CST)
Received: from [192.168.25.134] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 5D03337C969;
	Wed, 28 Feb 2024 21:22:48 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------mGv3ffdoapCw0RaRUGj7nJoT"
Message-ID: <a8b23de9-1f35-48e9-a4af-8041bbd89739@sjtu.edu.cn>
Date: Wed, 28 Feb 2024 21:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: introduce atomic operations
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20240228082107.1014131-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240228082107.1014131-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------mGv3ffdoapCw0RaRUGj7nJoT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/28/24 16:21, Gao Xiang wrote:
> Add some helpers (relaxed semantics) in order to prepare for the
> upcoming multi-threaded support.
>
> For example, compressor may be initialized more than once in different
> worker threads, resulting in noisy warnings.
>
> This patch makes sure that each message will be printed only once by
> adding `__warnonce` atomic booleans to each erofs_compressor_init().
>
> Cc: Yifan Zhao<zhaoyifan@sjtu.edu.cn>
> Signed-off-by: Gao Xiang<hsiangkao@linux.alibaba.com>
> ---
>   include/erofs/atomic.h      | 27 +++++++++++++++++++++++++++
>   lib/compressor_deflate.c    | 11 ++++++++---
>   lib/compressor_libdeflate.c |  6 +++++-
>   lib/compressor_liblzma.c    |  5 ++++-
>   4 files changed, 44 insertions(+), 5 deletions(-)
>   create mode 100644 include/erofs/atomic.h
>
> diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
> new file mode 100644
> index 0000000..c486491
> --- /dev/null
> +++ b/include/erofs/atomic.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * Copyright (C) 2024 Alibaba Cloud
> + */
> +#ifndef __EROFS_ATOMIC_H
> +#define __EROFS_ATOMIC_H
> +
> +/*
> + * Just use GCC/clang built-in functions for now
> + * See:https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
> + */
> +typedef unsigned long erofs_atomic_t;

According to [1] *__atomic_test_and_set *should**only be used for 
operands of type bool or char.

[1] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html

Maybe add

/typedef bool erofs_atomic_bool_t;
/

for this purpose?

Otherwise LGTM and I will include it in my patchset.


Thanks,

Yifan Zhao

> +
> +#define erofs_atomic_read(ptr) ({ \
> +	typeof(*ptr) __n;    \
> +	__atomic_load(ptr, &__n, __ATOMIC_RELAXED); \
> +__n;})
> +
> +#define erofs_atomic_set(ptr, n) do { \
> +	typeof(*ptr) __n = (n);    \
> +	__atomic_store(ptr, &__n, __ATOMIC_RELAXED); \
> +} while(0)
> +
> +#define erofs_atomic_test_and_set(ptr) \
> +	__atomic_test_and_set(ptr, __ATOMIC_RELAXED)
> +
> +#endif
> diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
> index 8629415..60bb2f6 100644
> --- a/lib/compressor_deflate.c
> +++ b/lib/compressor_deflate.c
> @@ -7,6 +7,7 @@
>   #include "erofs/print.h"
>   #include "erofs/config.h"
>   #include "compressor.h"
> +#include "erofs/atomic.h"
>   
>   void *kite_deflate_init(int level, unsigned int dict_size);
>   void kite_deflate_end(void *s);
> @@ -36,6 +37,8 @@ static int compressor_deflate_exit(struct erofs_compress *c)
>   
>   static int compressor_deflate_init(struct erofs_compress *c)
>   {
> +	static erofs_atomic_t __warnonce;
> +
>   	if (c->private_data) {
>   		kite_deflate_end(c->private_data);
>   		c->private_data = NULL;
> @@ -44,9 +47,11 @@ static int compressor_deflate_init(struct erofs_compress *c)
>   	if (IS_ERR_VALUE(c->private_data))
>   		return PTR_ERR(c->private_data);
>   
> -	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
> -	erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
> -	erofs_warn("Please send a report to<linux-erofs@lists.ozlabs.org>  if something is wrong.");
> +	if (!erofs_atomic_test_and_set(&__warnonce)) {
> +		erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
> +		erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
> +		erofs_warn("Please send a report to<linux-erofs@lists.ozlabs.org>  if something is wrong.");
> +	}
>   	return 0;
>   }
>   
> diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
> index 62d93f7..f90d720 100644
> --- a/lib/compressor_libdeflate.c
> +++ b/lib/compressor_libdeflate.c
> @@ -4,6 +4,7 @@
>   #include "erofs/config.h"
>   #include <libdeflate.h>
>   #include "compressor.h"
> +#include "erofs/atomic.h"
>   
>   static int libdeflate_compress_destsize(const struct erofs_compress *c,
>   				        const void *src, unsigned int *srcsize,
> @@ -82,12 +83,15 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
>   
>   static int compressor_libdeflate_init(struct erofs_compress *c)
>   {
> +	static erofs_atomic_t __warnonce;
> +
>   	libdeflate_free_compressor(c->private_data);
>   	c->private_data = libdeflate_alloc_compressor(c->compression_level);
>   	if (!c->private_data)
>   		return -ENOMEM;
>   
> -	erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
> +	if (!erofs_atomic_test_and_set(&__warnonce))
> +		erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
>   	return 0;
>   }
>   
> diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
> index 712f44f..e79717d 100644
> --- a/lib/compressor_liblzma.c
> +++ b/lib/compressor_liblzma.c
> @@ -9,6 +9,7 @@
>   #include "erofs/config.h"
>   #include "erofs/print.h"
>   #include "erofs/internal.h"
> +#include "erofs/atomic.h"
>   #include "compressor.h"
>   
>   struct erofs_liblzma_context {
> @@ -85,6 +86,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
>   {
>   	struct erofs_liblzma_context *ctx;
>   	u32 preset;
> +	static erofs_atomic_t __warnonce;
>   
>   	ctx = malloc(sizeof(*ctx));
>   	if (!ctx)
> @@ -103,7 +105,8 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
>   	ctx->opt.dict_size = c->dict_size;
>   
>   	c->private_data = ctx;
> -	erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
> +	if (!erofs_atomic_test_and_set(&__warnonce))
> +		erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
>   	return 0;
>   }
>   
--------------mGv3ffdoapCw0RaRUGj7nJoT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/28/24 16:21, Gao Xiang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240228082107.1014131-1-hsiangkao@linux.alibaba.com">
      <pre class="moz-quote-pre" wrap="">Add some helpers (relaxed semantics) in order to prepare for the
upcoming multi-threaded support.

For example, compressor may be initialized more than once in different
worker threads, resulting in noisy warnings.

This patch makes sure that each message will be printed only once by
adding `__warnonce` atomic booleans to each erofs_compressor_init().

Cc: Yifan Zhao <a class="moz-txt-link-rfc2396E" href="mailto:zhaoyifan@sjtu.edu.cn">&lt;zhaoyifan@sjtu.edu.cn&gt;</a>
Signed-off-by: Gao Xiang <a class="moz-txt-link-rfc2396E" href="mailto:hsiangkao@linux.alibaba.com">&lt;hsiangkao@linux.alibaba.com&gt;</a>
---
 include/erofs/atomic.h      | 27 +++++++++++++++++++++++++++
 lib/compressor_deflate.c    | 11 ++++++++---
 lib/compressor_libdeflate.c |  6 +++++-
 lib/compressor_liblzma.c    |  5 ++++-
 4 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 include/erofs/atomic.h

diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
new file mode 100644
index 0000000..c486491
--- /dev/null
+++ b/include/erofs/atomic.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2024 Alibaba Cloud
+ */
+#ifndef __EROFS_ATOMIC_H
+#define __EROFS_ATOMIC_H
+
+/*
+ * Just use GCC/clang built-in functions for now
+ * See: <a class="moz-txt-link-freetext" href="https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html">https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html</a>
+ */
+typedef unsigned long erofs_atomic_t;</pre>
    </blockquote>
    <p>According to [1] <strong class="def-name"
style="font-family: monospace; font-weight: bold; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">__atomic_test_and_set
      </strong><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">should</span><strong
        class="def-name"
style="font-family: monospace; font-weight: bold; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      </strong><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">only
        be used for operands of type bool or char.</span></p>
    <p>[1]  <span style="white-space: pre-wrap"><a class="moz-txt-link-freetext" href="https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html">https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html</a></span></p>
    <p><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Maybe
        add<br>
      </span></p>
    <p><i><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">   
          typedef bool erofs_atomic_bool_t;<br>
        </span></i></p>
    <p><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">for
        this purpose?<br>
      </span></p>
    <p><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Otherwise
        LGTM and I will include it in my patchset.</span></p>
    <p><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><br>
      </span></p>
    <p><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Thanks,<br>
      </span></p>
    <p><span class="def-name"
style="font-family: monospace; font-size: larger; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Yifan
        Zhao</span></p>
    <blockquote type="cite"
      cite="mid:20240228082107.1014131-1-hsiangkao@linux.alibaba.com">
      <pre class="moz-quote-pre" wrap="">
+
+#define erofs_atomic_read(ptr) ({ \
+	typeof(*ptr) __n;    \
+	__atomic_load(ptr, &amp;__n, __ATOMIC_RELAXED); \
+__n;})
+
+#define erofs_atomic_set(ptr, n) do { \
+	typeof(*ptr) __n = (n);    \
+	__atomic_store(ptr, &amp;__n, __ATOMIC_RELAXED); \
+} while(0)
+
+#define erofs_atomic_test_and_set(ptr) \
+	__atomic_test_and_set(ptr, __ATOMIC_RELAXED)
+
+#endif
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 8629415..60bb2f6 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -7,6 +7,7 @@
 #include "erofs/print.h"
 #include "erofs/config.h"
 #include "compressor.h"
+#include "erofs/atomic.h"
 
 void *kite_deflate_init(int level, unsigned int dict_size);
 void kite_deflate_end(void *s);
@@ -36,6 +37,8 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 
 static int compressor_deflate_init(struct erofs_compress *c)
 {
+	static erofs_atomic_t __warnonce;
+
 	if (c-&gt;private_data) {
 		kite_deflate_end(c-&gt;private_data);
 		c-&gt;private_data = NULL;
@@ -44,9 +47,11 @@ static int compressor_deflate_init(struct erofs_compress *c)
 	if (IS_ERR_VALUE(c-&gt;private_data))
 		return PTR_ERR(c-&gt;private_data);
 
-	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
-	erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
-	erofs_warn("Please send a report to <a class="moz-txt-link-rfc2396E" href="mailto:linux-erofs@lists.ozlabs.org">&lt;linux-erofs@lists.ozlabs.org&gt;</a> if something is wrong.");
+	if (!erofs_atomic_test_and_set(&amp;__warnonce)) {
+		erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
+		erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
+		erofs_warn("Please send a report to <a class="moz-txt-link-rfc2396E" href="mailto:linux-erofs@lists.ozlabs.org">&lt;linux-erofs@lists.ozlabs.org&gt;</a> if something is wrong.");
+	}
 	return 0;
 }
 
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index 62d93f7..f90d720 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -4,6 +4,7 @@
 #include "erofs/config.h"
 #include &lt;libdeflate.h&gt;
 #include "compressor.h"
+#include "erofs/atomic.h"
 
 static int libdeflate_compress_destsize(const struct erofs_compress *c,
 				        const void *src, unsigned int *srcsize,
@@ -82,12 +83,15 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
 
 static int compressor_libdeflate_init(struct erofs_compress *c)
 {
+	static erofs_atomic_t __warnonce;
+
 	libdeflate_free_compressor(c-&gt;private_data);
 	c-&gt;private_data = libdeflate_alloc_compressor(c-&gt;compression_level);
 	if (!c-&gt;private_data)
 		return -ENOMEM;
 
-	erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
+	if (!erofs_atomic_test_and_set(&amp;__warnonce))
+		erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
 	return 0;
 }
 
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 712f44f..e79717d 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -9,6 +9,7 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/internal.h"
+#include "erofs/atomic.h"
 #include "compressor.h"
 
 struct erofs_liblzma_context {
@@ -85,6 +86,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 {
 	struct erofs_liblzma_context *ctx;
 	u32 preset;
+	static erofs_atomic_t __warnonce;
 
 	ctx = malloc(sizeof(*ctx));
 	if (!ctx)
@@ -103,7 +105,8 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 	ctx-&gt;opt.dict_size = c-&gt;dict_size;
 
 	c-&gt;private_data = ctx;
-	erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
+	if (!erofs_atomic_test_and_set(&amp;__warnonce))
+		erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
 	return 0;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------mGv3ffdoapCw0RaRUGj7nJoT--
