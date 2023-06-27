Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560C73FC57
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 15:03:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=lc/lRQ7R;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qr4dd1YFVz30Np
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 23:03:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=lc/lRQ7R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qr4dY5YhJz2yGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 23:03:12 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4374991b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687870987; x=1690462987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tejWPoxQKivsuaisWLSOSzZ4phuUC47lI/+zqkt11ys=;
        b=lc/lRQ7RVAdQEIqTI0A7E1Izmo6igiDfVIi2NF7Ord/aKdwNbU7+zE9Ipj1YXdqVZ7
         NbOCg/CTfJvborRvAuOQePHBBsAQTi3ZxgXH1ceh/+U6R1rrYtVmttL0MjhlvRJdT2mV
         YQ7fK1xRTSE1sP2rk/yhEcnqHZfrEAwd/aBmPcKZXRqY0I1ulNU0odhXtaKAzMNyTgi1
         AyBqwQTbxKWpeK5MEW5BG5K0DDxznR391oc7bPKG0bFdhFW139RmTQJdmGG1XlYmMcjx
         JvbdIdLSUHePdUHv0KCoQXwVNmtY1HMlt9/ukb+cEcXXWFKAApSm4XGJdxFRX+hVuiGR
         2mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870987; x=1690462987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tejWPoxQKivsuaisWLSOSzZ4phuUC47lI/+zqkt11ys=;
        b=JSRpdO5m1myCCLVKd+uikbuMPvVW653hv88BRe39xvrgxdnITeQkLmKElsiMTAgbK8
         XFFJTgNjbvNnU3QCI5IjB5t14talwsI0AOJt84qm6X/ELKHHt4r7dUy0TUV6vRcpIsYJ
         Pp91GOQVXMjxh3CXlErGFxsGlkUkkRqJUMLBqO0/JO+bx4KsvlnLcpScLwT1qwoyJhSp
         qj1UHOgC9cVQPrGQCd31PxXDLqzrCFEtIgKtpGXYdpNapfvmlUxdQ6UXfgumm2Z4qge6
         HKwyRsis6g3C9kPJy+Y5ONGbdhH5M/rNzPempgwxuyZIQTZzY/q6BSP/iwOvsogaDufg
         lrKA==
X-Gm-Message-State: AC+VfDzdxRJYbqRUHJ1U1K/hIFFBSEslG6qYnXPguTUtmEYPtB1klpO1
	Go7RxAxitrw29uWN0oBtb5w=
X-Google-Smtp-Source: ACHHUZ6V1XxTXXjafgoAiGAyqz45GHe7voQPfwyQ9BSS6uGUEW+tNEeZ7kTwmymnllPQ4ITvT1+Tlg==
X-Received: by 2002:a05:6a00:2d9a:b0:66a:525f:64a7 with SMTP id fb26-20020a056a002d9a00b0066a525f64a7mr19483054pfb.16.1687870987304;
        Tue, 27 Jun 2023 06:03:07 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b00671eb039b23sm4173376pfn.58.2023.06.27.06.03.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Jun 2023 06:03:07 -0700 (PDT)
Date: Tue, 27 Jun 2023 21:11:44 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: fsck: add support for extracting hard
 links
Message-ID: <20230627211144.0000229b.zbestahu@gmail.com>
In-Reply-To: <1867cbe7-184a-2847-fa7a-d01ccd2f72f2@linux.alibaba.com>
References: <20230627085332.27974-1-zbestahu@gmail.com>
	<1867cbe7-184a-2847-fa7a-d01ccd2f72f2@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 27 Jun 2023 17:47:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On 2023/6/27 16:53, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Currently hard links can't be extracted correctly, let's support it now.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> 
> Thanks for the patch!  Some minor comments below...
> 
> > ---
> >   fsck/main.c | 152 ++++++++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 124 insertions(+), 28 deletions(-)
> > 
> > diff --git a/fsck/main.c b/fsck/main.c
> > index f816bec..e78f67c 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -49,6 +49,16 @@ static struct option long_options[] = {
> >   	{0, 0, 0, 0},
> >   };
> >   
> > +#define NR_HARDLINK_HASHTABLE	16384
> > +
> > +struct hardlink_entry {  
> 
> erofsfsck_hardlink_entry {
> 
> or erofsfsck_linkentry if the above is too long
> 
> > +	struct list_head list;
> > +	erofs_nid_t nid;
> > +	char *path;
> > +};
> > +
> > +static struct list_head hardlink_hashtable[NR_HARDLINK_HASHTABLE];  
> 
> erofsfsck_link_hashtable
> 
> > +
> >   static void print_available_decompressors(FILE *f, const char *delim)
> >   {
> >   	unsigned int i = 0;
> > @@ -550,6 +560,64 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
> >   	return 0;
> >   }
> >   
> > +static char *erofsfsck_hardlink_find(erofs_nid_t nid)
> > +{
> > +	struct list_head *head =
> > +			&hardlink_hashtable[nid % NR_HARDLINK_HASHTABLE];
> > +	struct hardlink_entry *entry;
> > +
> > +	if (list_empty(head))
> > +		return NULL;  
> 
> why we need that?

yeah, it's unneeded, will remove it in v2.

> 
> > +
> > +	list_for_each_entry(entry, head, list)
> > +		if (entry->nid == nid)
> > +			return entry->path;
> > +	return NULL;
> > +}
> > +
> > +static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
> > +{
> > +	struct hardlink_entry *entry;
> > +
> > +	entry = malloc(sizeof(*entry));
> > +	if (!entry)
> > +		return -ENOMEM;
> > +
> > +	entry->nid = nid;
> > +	entry->path = strdup(path);
> > +	if (!entry->path)
> > +		return -ENOMEM;
> > +
> > +	list_add_tail(&entry->list,
> > +		      &hardlink_hashtable[nid % NR_HARDLINK_HASHTABLE]);
> > +	return 0;
> > +}
> > +
> > +static void erofsfsck_hardlink_init(void)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i)
> > +		init_list_head(&hardlink_hashtable[i]);
> > +}
> > +
> > +static void erofsfsck_hardlink_exit(void)
> > +{
> > +	struct hardlink_entry *entry, *n;
> > +	struct list_head *head;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i) {
> > +		head = &hardlink_hashtable[i];
> > +
> > +		list_for_each_entry_safe(entry, n, head, list) {
> > +			if (entry->path)
> > +				free(entry->path);
> > +			free(entry);
> > +		}
> > +	}
> > +}
> > +
> >   static inline int erofs_extract_file(struct erofs_inode *inode)
> >   {
> >   	bool tryagain = true;
> > @@ -719,6 +787,57 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
> >   	return ret;
> >   }
> >   
> > +static int erofsfsck_extract_inode(struct erofs_inode *inode)
> > +{
> > +	int ret;
> > +	char *oldpath;
> > +
> > +	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {  
> 
> why introducing erofs_is_packed_inode here?

hardlink hashtable will be initialized after verify packed inode. 

> 
> Thanks,
> Gao Xiang

