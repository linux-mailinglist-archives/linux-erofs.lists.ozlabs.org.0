Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC5173F8FC
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 11:47:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qr0J60r9wz30Q3
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 19:47:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qr0J00tHrz303R
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 19:47:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vm5J-cg_1687859253;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm5J-cg_1687859253)
          by smtp.aliyun-inc.com;
          Tue, 27 Jun 2023 17:47:34 +0800
Message-ID: <1867cbe7-184a-2847-fa7a-d01ccd2f72f2@linux.alibaba.com>
Date: Tue, 27 Jun 2023 17:47:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: fsck: add support for extracting hard links
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230627085332.27974-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230627085332.27974-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2023/6/27 16:53, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Currently hard links can't be extracted correctly, let's support it now.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Thanks for the patch!  Some minor comments below...

> ---
>   fsck/main.c | 152 ++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 124 insertions(+), 28 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index f816bec..e78f67c 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -49,6 +49,16 @@ static struct option long_options[] = {
>   	{0, 0, 0, 0},
>   };
>   
> +#define NR_HARDLINK_HASHTABLE	16384
> +
> +struct hardlink_entry {

erofsfsck_hardlink_entry {

or erofsfsck_linkentry if the above is too long

> +	struct list_head list;
> +	erofs_nid_t nid;
> +	char *path;
> +};
> +
> +static struct list_head hardlink_hashtable[NR_HARDLINK_HASHTABLE];

erofsfsck_link_hashtable

> +
>   static void print_available_decompressors(FILE *f, const char *delim)
>   {
>   	unsigned int i = 0;
> @@ -550,6 +560,64 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
>   	return 0;
>   }
>   
> +static char *erofsfsck_hardlink_find(erofs_nid_t nid)
> +{
> +	struct list_head *head =
> +			&hardlink_hashtable[nid % NR_HARDLINK_HASHTABLE];
> +	struct hardlink_entry *entry;
> +
> +	if (list_empty(head))
> +		return NULL;

why we need that?

> +
> +	list_for_each_entry(entry, head, list)
> +		if (entry->nid == nid)
> +			return entry->path;
> +	return NULL;
> +}
> +
> +static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
> +{
> +	struct hardlink_entry *entry;
> +
> +	entry = malloc(sizeof(*entry));
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->nid = nid;
> +	entry->path = strdup(path);
> +	if (!entry->path)
> +		return -ENOMEM;
> +
> +	list_add_tail(&entry->list,
> +		      &hardlink_hashtable[nid % NR_HARDLINK_HASHTABLE]);
> +	return 0;
> +}
> +
> +static void erofsfsck_hardlink_init(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i)
> +		init_list_head(&hardlink_hashtable[i]);
> +}
> +
> +static void erofsfsck_hardlink_exit(void)
> +{
> +	struct hardlink_entry *entry, *n;
> +	struct list_head *head;
> +	unsigned int i;
> +
> +	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i) {
> +		head = &hardlink_hashtable[i];
> +
> +		list_for_each_entry_safe(entry, n, head, list) {
> +			if (entry->path)
> +				free(entry->path);
> +			free(entry);
> +		}
> +	}
> +}
> +
>   static inline int erofs_extract_file(struct erofs_inode *inode)
>   {
>   	bool tryagain = true;
> @@ -719,6 +787,57 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
>   	return ret;
>   }
>   
> +static int erofsfsck_extract_inode(struct erofs_inode *inode)
> +{
> +	int ret;
> +	char *oldpath;
> +
> +	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {

why introducing erofs_is_packed_inode here?

Thanks,
Gao Xiang
