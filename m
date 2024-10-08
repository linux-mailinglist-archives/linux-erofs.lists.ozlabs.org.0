Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B41993CB9
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 04:13:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN01n3rPqz30Ns
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 13:13:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728353628;
	cv=none; b=gIOuqlDAKOBmXOfM4dG4ohLE7biP9LtQwlAlGrBnOoq6sAqnUYCl6fPHhOQmhaDw002AlozQunCdb3AMkoqaBxhQNEziJOXurs3so74naDJNsz8yMCsvFdez1TCgW4XhmQXXMIMgCFzZcP9aqbPIKqbWnE3uWcWIspikSpGM+wkqhLJj1pl5ncCxMLQ0uXWM6p3HPhwO+Ig0TYYEhBZlxW+U/U3nagvoGrSFDq2VNoiHhdfw9tjc/VwKpXjxupX+/yiH++A+dKrATST6RiJUnyd6cgys5FhXo/3WqQI2uQguq5iQDexkpWh2GpsBsIi5N5/abR3fvNPdg+CMqMEqew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728353628; c=relaxed/relaxed;
	bh=/QfZfSGLLAY055ZVAzgt+JLVSi3pnbXH30CE8nx9K/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFT6boie1tlLQe8V/amsdM4He+ya6TefAKobcJ8uNQOlkxS55Sg/Ei587ysl3VnstK2vupNUY94p3I70Jdyw5hiNN9qF3aY+jJlC+11WxLHoaIz19mgVZ+T6ZWqC64BwjeZX9FLB+rz9Oh89B/y+6O6r04j9XDtpGFd6B8VwgeIOzJ9Tlw07TkwU+LagU2oQ+FtjKGWM4kxPv/sYISxr+ts9RZ0q3RVtOBFja0GjsU2+7ZlHuNrSs5yKysB8tLxY8UB/Ak+FfpOuqyUX3bxZAlULCm9ihwEX+oLfkhDU3AWCCdOg9nvgHI/IhmgFHiFbj7htGZQHyX+/9HVrlVA1IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sV8ISHKo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sV8ISHKo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN01j0DPQz2ysb
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 13:13:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728353615; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/QfZfSGLLAY055ZVAzgt+JLVSi3pnbXH30CE8nx9K/E=;
	b=sV8ISHKooLEXUZPC7i69gWAKCDGlSVngXtNyTOMAEtCskBkCdIETpQKz3TmBgOfxdjaKA/hk0JzPEwEWuEiTcotvWRh8CdhtKR5w+TGsN0gcXECyER9sODd4OiqYlVnTQYIPvFlcSAaZrpiQJvUuPxVW5OhX6zUQlINeu11yqMI=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGXTr9V_1728353612)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 10:13:33 +0800
Message-ID: <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
Date: Tue, 8 Oct 2024 10:13:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Christian Brauner <brauner@kernel.org>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
 <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

On 2024/10/7 19:35, Christian Brauner wrote:
> On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:

...

>>
>> Hi Christian, if possible, could you give some other
>> idea to handle this case better? Many thanks!

Thanks for the reply!

> 
> (1) Require that the path be qualified like:
> 
>      fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)
> 
>      and match on it in either erofs_*_get_tree() or by adding a custom
>      function for the Opt_source/"source" parameter.

IMHO, Users could create names with the prefix `file:`,
it's somewhat strange to define a fixed prefix by the
definition of source path fc->source.

Although there could be some escape character likewise
way, but I'm not sure if it's worthwhile to work out
this in kernel.

> 
> (2) Add a erofs specific "source-file" mount option. IOW, check that
>      either "source-file" or "source" was specified but not both. You
>      could even set fc->source to "source-file" value and fail if
>      fc->source is already set. You get the idea.

I once thought to add a new mount option too, yet from
the user perpertive, I think users may not care about
the source type of an arbitary path, and the kernel also
can parse the type of the source path directly... so..


So.. I wonder if it's possible to add a new VFS interface
like get_tree_bdev_by_dev() for filesystems to specify a
device number rather than hardcoded hard-coded source path
way, e.g. I could see the potential benefits other than
the EROFS use case:

  - Filesystems can have other ways to get a bdev-based sb
    in addition to the current hard-coded source path way;

  - Some pseudo fs can use this way to generate a fs from a
    bdev.

  - Just like get_tree_nodev(), it doesn't strictly tie to
    fc->source too.

Also EROFS could lookup_bdev() (this kAPI is already
exported) itself to check if it uses get_tree_bdev_by_dev()
or get_tree_nodev()... Does it sounds good?  Many thanks!

Thanks,
Gao Xiang

diff --git a/fs/super.c b/fs/super.c
index 1db230432960..8cc8350b9ba6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1596,26 +1596,17 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
  EXPORT_SYMBOL_GPL(setup_bdev_super);
  
  /**
- * get_tree_bdev - Get a superblock based on a single block device
+ * get_tree_bdev_by_dev - Get a bdev-based superblock with a given device number
   * @fc: The filesystem context holding the parameters
   * @fill_super: Helper to initialise a new superblock
+ * @dev: The device number indicating the target block device
   */
-int get_tree_bdev(struct fs_context *fc,
+int get_tree_bdev_by_dev(struct fs_context *fc,
  		int (*fill_super)(struct super_block *,
-				  struct fs_context *))
+				  struct fs_context *), dev_t dev)
  {
  	struct super_block *s;
  	int error = 0;
-	dev_t dev;
-
-	if (!fc->source)
-		return invalf(fc, "No source specified");
-
-	error = lookup_bdev(fc->source, &dev);
-	if (error) {
-		errorf(fc, "%s: Can't lookup blockdev", fc->source);
-		return error;
-	}
  
  	fc->sb_flags |= SB_NOSEC;
  	s = sget_dev(fc, dev);
@@ -1644,6 +1635,30 @@ int get_tree_bdev(struct fs_context *fc,
  	fc->root = dget(s->s_root);
  	return 0;
  }
+EXPORT_SYMBOL_GPL(get_tree_bdev_by_dev);
+
+/**
+ * get_tree_bdev - Get a superblock based on a single block device
+ * @fc: The filesystem context holding the parameters
+ * @fill_super: Helper to initialise a new superblock
+ */
+int get_tree_bdev(struct fs_context *fc,
+		int (*fill_super)(struct super_block *,
+				  struct fs_context *))
+{
+	int error;
+	dev_t dev;
+
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+
+	error = lookup_bdev(fc->source, &dev);
+	if (error) {
+		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		return error;
+	}
+	return get_tree_bdev_by_dev(fc, fill_super, dev);
+}
  EXPORT_SYMBOL(get_tree_bdev);
  
  static int test_bdev_super(struct super_block *s, void *data)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..54f23589ad5b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -160,6 +160,9 @@ extern int get_tree_keyed(struct fs_context *fc,
  
  int setup_bdev_super(struct super_block *sb, int sb_flags,
  		struct fs_context *fc);
+int get_tree_bdev_by_dev(struct fs_context *fc,
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc), dev_t dev);
  extern int get_tree_bdev(struct fs_context *fc,
  			       int (*fill_super)(struct super_block *sb,
  						 struct fs_context *fc));


> 
> ?

