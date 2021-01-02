Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 639792E8648
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 06:10:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D792G6rhRzDqJQ
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 16:10:30 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=BF/ygUfe; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BF/ygUfe; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D79242jWczDqJP
 for <linux-erofs@lists.ozlabs.org>; Sat,  2 Jan 2021 16:10:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609564211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jof8Qad3PX6kDPlaWEyPL5FqCawg/1/UA8fc4AfnE+c=;
 b=BF/ygUfeu0h8GpEgCHEv/FNE/sYuKUdcnztORLPcxxA4qyYbmwyTv+MPRKCdmnZ8Pbn7rJ
 h6SiLuYHGBzxhipuIiT1HOPsHtfUHK/SJpsmVH9o/VjJg4GqZETgUBIBQ4OlV+IvYZA/sh
 3UF+T0bPwQOLiSSleqxeOGTTxpWgQr8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609564211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jof8Qad3PX6kDPlaWEyPL5FqCawg/1/UA8fc4AfnE+c=;
 b=BF/ygUfeu0h8GpEgCHEv/FNE/sYuKUdcnztORLPcxxA4qyYbmwyTv+MPRKCdmnZ8Pbn7rJ
 h6SiLuYHGBzxhipuIiT1HOPsHtfUHK/SJpsmVH9o/VjJg4GqZETgUBIBQ4OlV+IvYZA/sh
 3UF+T0bPwQOLiSSleqxeOGTTxpWgQr8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-GIy3xSmxPli9VOK-4wi3Zg-1; Sat, 02 Jan 2021 00:10:08 -0500
X-MC-Unique: GIy3xSmxPli9VOK-4wi3Zg-1
Received: by mail-pg1-f200.google.com with SMTP id 24so16869433pgt.4
 for <linux-erofs@lists.ozlabs.org>; Fri, 01 Jan 2021 21:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Jof8Qad3PX6kDPlaWEyPL5FqCawg/1/UA8fc4AfnE+c=;
 b=j3KSqqEaoThGgYY0RMgKe2qOwiyEIVoTH9noyNz1wAtsQnC6tFZ+oqro0u5GcwAXFV
 OY8pYAQRMpO1oIfnGLJgEmFSe2IYt1d7OsCgGu7t6AKo+E4ZAIhEj7SICc/yr+/vMmof
 hq22wmwV1bcenH9FR1/7cCIpHrpurMhRjEt++NRzuk3MtKXRj3b26MZ4IGkFO+Vj4xZY
 PEGct6x83yqUmuyMqpQ1tSvlcdre4oSx4xplkIpOABATS3CniZSvs/N9YFj6YGwpCCrn
 xBl0GMGcIQEl4UBnmOhVwwYhWx9yUuMLQjKQOudoXCV6t+jKklR7dohmre9mryh8pt0F
 oXMw==
X-Gm-Message-State: AOAM533VTXc2uwVfwGP5hzOLS90Fv92/1z7kAyIPaEWiv7Tbu8Mqilr0
 uIRkYgg9E9wjA+SGk0WJ3dLoWJan6g8sJekSdrS2GLbf31o1YcuCRQQR7MD5ADd+RtGt2oZjlZa
 wvMGRWEIPHiez5tkxaSbArhwj
X-Received: by 2002:a17:902:7289:b029:dc:38b7:c57e with SMTP id
 d9-20020a1709027289b02900dc38b7c57emr56173344pll.72.1609564207643; 
 Fri, 01 Jan 2021 21:10:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvJQ9BbJyuOMs6BhxWPMfXz+5qzbYeLYsnIbk98m+E7hhvrQ8/0ldsAV1izpRawYhA0w6yew==
X-Received: by 2002:a17:902:7289:b029:dc:38b7:c57e with SMTP id
 d9-20020a1709027289b02900dc38b7c57emr56173324pll.72.1609564207257; 
 Fri, 01 Jan 2021 21:10:07 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l2sm15167102pjz.27.2021.01.01.21.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Jan 2021 21:10:06 -0800 (PST)
Date: Sat, 2 Jan 2021 13:09:57 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOhIOeOruaWhw==?= <huww98@outlook.com>
Subject: Re: [PATCH 1/2] erofs-utils: optimize mkfs to O(N), N = #files
Message-ID: <20210102050957.GA3732199@xiangao.remote.csb>
References: <ME3P282MB1938A1CE1C6AF60BE7F955F7C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
 <ME3P282MB1938B2C9837F9767503036D8C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <ME3P282MB1938B2C9837F9767503036D8C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 01, 2021 at 09:50:24AM +0000, 胡 玮文 wrote:
> Hi all,
> 
> This is my first time sending patches by email. If something is not properly done, please point it out.
> 
> I have a question for now: How am I supposed to submit patches to erofs-utils now? Some E-mail address listed in AUTHORS and README seems no longer valid (email to gaoxiang25@huawei.com<mailto:gaoxiang25@huawei.com> was rejected). Is it enough to post the patches to this mailing list? I added all addresses in README, but I got a message said my email is rejected. I’m not sure who actually received my email.

My email has been changed, I might need to update my email address to hsiangkao@redhat.com...
Thanks for point out!

Yeah, that could cause bottleneck when files increased (Android only have < 10000 files),
so it needs to be improve. I will look into your patch later (working on another things now...)
Hope Guifu or other folks could also help reviewing that...

Thanks,
Gao Xiang

> 
> 发件人: 胡 玮文<mailto:huww98@outlook.com>
> 发送时间: 2021年1月1日 17:16
> 收件人: Li Guifu<mailto:bluce.liguifu@huawei.com>; Miao Xie<mailto:miaoxie@huawei.com>; Fang Wei<mailto:fangwei1@huawei.com>
> 抄送: Gao Xiang<mailto:gaoxiang25@huawei.com>; Chao Yu<mailto:yuchao0@huawei.com>; linux-erofs@lists.ozlabs.org<mailto:linux-erofs@lists.ozlabs.org>; 胡玮文<mailto:huww98@outlook.com>
> 主题: [PATCH 1/2] erofs-utils: optimize mkfs to O(N), N = #files
> 
> When using EROFS to pack our dataset which consists of millions of
> files, mkfs.erofs is very slow compared with mksquashfs.
> 
> The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
> iterate over all previously allocated buffer blocks, making the
> complexity of the algrithm O(N^2) where N is the number of files.
> 
> With this patch:
> 
> * global `last_mapped_block` is mantained to avoid full scan in
>   `erofs_mapbh` function.
> 
> * global `non_full_buffer_blocks` mantains a list of buffer block for
>   each type and each possible remaining bytes in the block. Then it is
>   used to identify the most suitable blocks in future `erofs_balloc`,
>   avoiding full scan.
> 
> Some new data structure is allocated in this patch, more RAM usage is
> expected, but not much. When I test it with ImageNet dataset (1.33M
> files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
> spent on IO.
> 
> Signed-off-by: Hu Weiwen <huww98@outlook.com>
> ---
>  lib/cache.c | 102 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 89 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/cache.c b/lib/cache.c
> index 0d5c4a5..3412a0b 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -18,6 +18,18 @@ static struct erofs_buffer_block blkh = {
>  };
>  static erofs_blk_t tail_blkaddr;
> 
> +/**
> + * Some buffers are not full, we can reuse it to store more data
> + * 2 for DATA, META
> + * EROFS_BLKSIZ for each possible remaining bytes in the last block
> + **/
> +static struct erofs_buffer_block_record {
> +       struct list_head list;
> +       struct erofs_buffer_block *bb;
> +} non_full_buffer_blocks[2][EROFS_BLKSIZ];
> +
> +static struct erofs_buffer_block *last_mapped_block = &blkh;
> +
>  static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
>  {
>          return erofs_bh_flush_generic_end(bh);
> @@ -62,6 +74,12 @@ struct erofs_bhops erofs_buf_write_bhops = {
>  /* return buffer_head of erofs super block (with size 0) */
>  struct erofs_buffer_head *erofs_buffer_init(void)
>  {
> +       for (int i = 0; i < 2; i++) {
> +               for (int j = 0; j < EROFS_BLKSIZ; j++) {
> +                       init_list_head(&non_full_buffer_blocks[i][j].list);
> +               }
> +       }
> +
>          struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
> 
>          if (IS_ERR(bh))
> @@ -131,7 +149,8 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  {
>          struct erofs_buffer_block *cur, *bb;
>          struct erofs_buffer_head *bh;
> -       unsigned int alignsize, used0, usedmax;
> +       unsigned int alignsize, used0, usedmax, total_size;
> +       struct erofs_buffer_block_record * reusing = NULL;
> 
>          int ret = get_alignsize(type, &type);
> 
> @@ -143,7 +162,38 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>          usedmax = 0;
>          bb = NULL;
> 
> -       list_for_each_entry(cur, &blkh.list, list) {
> +       erofs_dbg("balloc size=%lu alignsize=%u used0=%u", size, alignsize, used0);
> +       if (used0 == 0 || alignsize == EROFS_BLKSIZ) {
> +               goto alloc;
> +       }
> +       total_size = size + required_ext + inline_ext;
> +       if (total_size < EROFS_BLKSIZ) {
> +               // Try find a most fit block.
> +               DBG_BUGON(type < 0 || type > 1);
> +               struct erofs_buffer_block_record *non_fulls = non_full_buffer_blocks[type];
> +               for (struct erofs_buffer_block_record *r = non_fulls + round_up(total_size, alignsize);
> +                               r < non_fulls + EROFS_BLKSIZ; r++) {
> +                       if (!list_empty(&r->list)) {
> +                               struct erofs_buffer_block_record *reuse_candidate =
> +                                               list_first_entry(&r->list, struct erofs_buffer_block_record, list);
> +                               ret = __erofs_battach(reuse_candidate->bb, NULL, size, alignsize,
> +                                               required_ext + inline_ext, true);
> +                               if (ret >= 0) {
> +                                       reusing = reuse_candidate;
> +                                       bb = reuse_candidate->bb;
> +                                       usedmax = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
> +                               }
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       /* Try reuse last ones, which are not mapped and can be extended */
> +       cur = last_mapped_block;
> +       if (cur == &blkh) {
> +               cur = list_next_entry(cur, list);
> +       }
> +       for (; cur != &blkh; cur = list_next_entry(cur, list)) {
>                  unsigned int used_before, used;
> 
>                  used_before = cur->buffers.off % EROFS_BLKSIZ;
> @@ -175,22 +225,32 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>                          continue;
> 
>                  if (usedmax < used) {
> +                       reusing = NULL;
>                          bb = cur;
>                          usedmax = used;
>                  }
>          }
> 
>          if (bb) {
> +               erofs_dbg("reusing buffer. usedmax=%u", usedmax);
>                  bh = malloc(sizeof(struct erofs_buffer_head));
>                  if (!bh)
>                          return ERR_PTR(-ENOMEM);
> +               if (reusing) {
> +                       list_del(&reusing->list);
> +                       free(reusing);
> +               }
>                  goto found;
>          }
> 
> +alloc:
>          /* allocate a new buffer block */
> -       if (used0 > EROFS_BLKSIZ)
> +       if (used0 > EROFS_BLKSIZ) {
> +               erofs_dbg("used0 > EROFS_BLKSIZ");
>                  return ERR_PTR(-ENOSPC);
> +       }
> 
> +       erofs_dbg("new buffer block");
>          bb = malloc(sizeof(struct erofs_buffer_block));
>          if (!bb)
>                  return ERR_PTR(-ENOMEM);
> @@ -211,6 +271,16 @@ found:
>                                required_ext + inline_ext, false);
>          if (ret < 0)
>                  return ERR_PTR(ret);
> +       if (ret != 0) {
> +               /* This buffer is not full yet, we may reuse it */
> +               reusing = malloc(sizeof(struct erofs_buffer_block_record));
> +               if (!reusing) {
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +               reusing->bb = bb;
> +               list_add_tail(&reusing->list,
> +                               &non_full_buffer_blocks[type][EROFS_BLKSIZ - ret - inline_ext].list);
> +       }
>          return bh;
>  }
> 
> @@ -247,8 +317,10 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
>  {
>          erofs_blk_t blkaddr;
> 
> -       if (bb->blkaddr == NULL_ADDR)
> +       if (bb->blkaddr == NULL_ADDR) {
>                  bb->blkaddr = tail_blkaddr;
> +               last_mapped_block = bb;
> +       }
> 
>          blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
>          if (blkaddr > tail_blkaddr)
> @@ -259,15 +331,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
> 
>  erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
>  {
> -       struct erofs_buffer_block *t, *nt;
> -
> -       if (!bb || bb->blkaddr == NULL_ADDR) {
> -               list_for_each_entry_safe(t, nt, &blkh.list, list) {
> -                       if (!end && (t == bb || nt == &blkh))
> -                               break;
> -                       (void)__erofs_mapbh(t);
> -                       if (end && t == bb)
> -                               break;
> +       DBG_BUGON(!end);
> +       struct erofs_buffer_block *t = last_mapped_block;
> +       while (1) {
> +               t = list_next_entry(t, list);
> +               if (t == &blkh) {
> +                       break;
> +               }
> +               (void)__erofs_mapbh(t);
> +               if (t == bb) {
> +                       break;
>                  }
>          }
>          return tail_blkaddr;
> @@ -334,6 +407,9 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
>          if (!list_empty(&bb->buffers.list))
>                  return;
> 
> +       if (bb == last_mapped_block) {
> +               last_mapped_block = list_prev_entry(bb, list);
> +       }
>          list_del(&bb->list);
>          free(bb);
> 
> --
> 2.30.0
> 

