Return-Path: <linux-erofs+bounces-1875-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93AD22008
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 02:22:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds4w65Xdpz2xqj;
	Thu, 15 Jan 2026 12:22:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768440134;
	cv=none; b=jKdJuAikuipjQbb7w71iwF+jX/QvzggmwVproqKDEAk19B3mzimfm1va1DGYZOjnvJP5mHgtEBSOAigEPQl+NYlA7DrB72vFLVjzzUFo38htjswnFISx3lsiQ45M8MvlbardU1rAXG6aT9Nbve8ZnZcr18egpjoaC0sfftCayc7qBbfrwLa9V0ilp+cIf8tqck2DB7p5ngXswS3HYzZuo4fEtAwx5g+CIKPq1XNyNFK5MY3N3emfzUppowy6YmThW/YuwmdeXFFFJ2T4K1w68OyMxOggoSjVMeKzpZmkF+AH5mSN9DQKZgCulCUpiaEO98XAstoIUAVTtE6iN5KIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768440134; c=relaxed/relaxed;
	bh=uGwfILC7yHCpfCV76sUs7dT+L7RgNEA3D9D+1vlxiww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dx2GvIbhrN60gMCu8qp33jL3r+oD4fHVtyFTetu+MCx0ZdRV3ZFyOOSN/bnpK8qopqUinXcYwrjk/LJ6uVXQzSvwc2lP9S9NWBExdIRp9wd/zSWYPyYMOnppQAWlDcIUi+Vemeof4SZoatwVGQNUqFjaGwWzuYAOAjVexaP76ceOtO4OrIYqeDBxZHi5JdK33cl3N6khUd2kCQxua0pC+bNnNCmBkObHYlIzc0ydra2A1sz192dz94HK+pUAKqUAv6L3ioBqDzARbHlyiJ9UV4cEqDRFirNHoMMeHYfEvTu3SbTDI7o8xC94pVqQABxTUN/ysanCQIQf3kOvOuU1sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gHnYkgCx; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gHnYkgCx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds4w34xnvz2xHW
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 12:22:09 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uGwfILC7yHCpfCV76sUs7dT+L7RgNEA3D9D+1vlxiww=;
	b=gHnYkgCxwlBBoAYob9FSaT1+YTZn8STnXamh4VOEEaAOi7+M4Bw1zFaFrS7TMk+eAbDhIzSNF
	00l0QYkO6y6tO28NeXmVD6aZycI5IIZEUE2OvDvh+5zE9bMQDgdF3tYKCWXlgrvZo4m7h0/lhUI
	CV+W2m4DtCi932MlzTOFNGo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ds4qz2KtlzKmSg;
	Thu, 15 Jan 2026 09:18:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id F04FF40536;
	Thu, 15 Jan 2026 09:21:59 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 09:21:59 +0800
Message-ID: <6ccc0f3f-56a5-4edb-a4c9-72d6e5090b7b@huawei.com>
Date: Thu, 15 Jan 2026 09:21:58 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/10] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-8-lihongbo22@huawei.com>
 <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,Xiang

On 2026/1/14 18:18, Gao Xiang wrote:
> 
> 
> On 2026/1/9 18:28, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
...

>> +
>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock_init(&vi->ishare_lock);
>> +    return 0;
>> +}
>> +
>> +bool erofs_ishare_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_inode_fingerprint fp;
>> +    struct inode *sharedinode;
>> +    unsigned long hash;
>> +
>> +    if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
>> +        return false;
>> +    hash = xxh32(fp.opaque, fp.size, 0);
>> +    sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>> +                   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>> +                   &fp);
>> +    if (!sharedinode) {
>> +        kfree(fp.opaque);
>> +        return false;
>> +    }
>> +
>> +    vi->sharedinode = sharedinode;
>> +    if (inode_state_read_once(sharedinode) & I_NEW) {
>> +        if (erofs_inode_is_data_compressed(vi->datalayout)) {
>> +            sharedinode->i_mapping->a_ops = &z_erofs_aops;
> 
> It seems that it caused a build warning:
> https://lore.kernel.org/r/202601130827.dHbGXL3Y-lkp@intel.com
> 
>> +        } else {
>> +            sharedinode->i_mapping->a_ops = &erofs_aops;
>> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>> +            if (erofs_is_fileio_mode(sbi))
>> +                sharedinode->i_mapping->a_ops = &erofs_fileio_aops;
>> +#endif
>> +        }
> 
> Can we introduce a new helper for those aops setting? such as:
> 
> void erofs_inode_set_aops(struct erofs_inode *inode,
>                struct erofs_inode *realinode, bool no_fscache)

Yeah, good idea. So it also can be reuse in erofs_fill_inode.

And how about declearing it as "int erofs_iode_set_aops(struct 
erofs_inode *inode, struct erofs_inode *realinode, bool no_fscache)"; 
because the compressed case may return -EOPNOTSUPP and it seems we 
cannot break this in advance. And can we mark it inline?

Thanks,
Hongbo

> {
>      if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
> #ifdef CONFIG_EROFS_FS_ZIP
>          DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>                  erofs_info, realinode->i_sb,
>                                "EXPERIMENTAL EROFS subpage compressed 
> block support in use. Use at your own risk!");
>          inode->i_mapping->a_ops = &z_erofs_aops;
> #else
>          err = -EOPNOTSUPP;
> #endif
>          } else {
>                  inode->i_mapping->a_ops = &erofs_aops;
> #ifdef CONFIG_EROFS_FS_ONDEMAND
>                  if (!nofscache && erofs_is_fscache_mode(realinode->i_sb))
>                          inode->i_mapping->a_ops = 
> &erofs_fscache_access_aops;
> #endif
> #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>                  if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
>                          inode->i_mapping->a_ops = &erofs_fileio_aops;
> #endif
>          }
> }
> 
> 
> 
>> +        sharedinode->i_mode = vi->vfs_inode.i_mode;
>> +        sharedinode->i_size = vi->vfs_inode.i_size;
>> +        unlock_new_inode(sharedinode);
>> +    } else {
>> +        kfree(fp.opaque);
>> +    }
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    return true;
>> +}
>> +
>> +void erofs_ishare_free_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct inode *sharedinode = vi->sharedinode;
>> +
>> +    if (!sharedinode)
>> +        return;
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_del(&vi->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    iput(sharedinode);
>> +    vi->sharedinode = NULL;
>> +}
>> +

...
>>           /*
>> @@ -719,6 +733,10 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>           erofs_info(sb, "unsupported blocksize for DAX");
>>           clear_opt(&sbi->opt, DAX_ALWAYS);
>>       }
>> +    if (test_opt(&sbi->opt, INODE_SHARE) && 
>> !erofs_sb_has_ishare_xattrs(sbi)) {
>> +        erofs_info(sb, "on-disk ishare xattrs not found. Turning off 
>> inode_share.");
>> +        clear_opt(&sbi->opt, INODE_SHARE);
>> +    }
> 
> It would be better to add a message like:
> 
>      if (test_opt(&sbi->opt, INODE_SHARE))
>          erofs_info(sb, "EXPERIMENTAL EROFS page cache share support in 
> use. Use at your own risk!");
> 
> At the end of erofs_read_superblock().
> 

Ok, I will add in next version.

Thanks,
Hongbo

> Thanks,
> Gao Xiang

