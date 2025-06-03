Return-Path: <linux-erofs+bounces-382-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A3ACBEFC
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:54:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBH0Y6Zv8z2yGM;
	Tue,  3 Jun 2025 13:54:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748922893;
	cv=none; b=JdchOVE6QzZs9pirY72Uf3+E/idMzHQ5ooKN1KmbKhy6t7bjDlob3hnijBvJs42q9foKEuB0yjK/AM+IMU4lNSQXE+6p5Oiz4LkvFiiLu1L/1wYA465naKi3x+2Va8tA4Qt3T/mV08dJx+k9RpQ8cRsXvxKUIl3eG9BkVdRmmujCbRIa/5yPDuvX3/DF1PYkMeCk1YXjojsxQt0qYnQCZMgY8TmlZuiU5d8ifC9r+6G1jCksGhUj3ayvq3jN3hKA4XxaActMKgEY/uESke0Gtw4J3Xdxezhn1Fg8aeKR/EnPjtgkI1nPmr6Yok6O8r8TmXsjBcXbMQQub1NrPtKVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748922893; c=relaxed/relaxed;
	bh=TBVpgKzX3OiQIAkkpfQxNYhLyFVyHOwHqez6q+6Rk+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=myThJ9MhXCm1sakjnfjfTXkhDn2stPGxgHT48ZulDr1uU8A3x4n+rMRZZKF+G1kaXMwPdmLHw45Ey5zHPC5WAMRY6oHPZeKhrBeqjvoSo4EWY+GKiKua3CRlEXXRG7yjGUYyQ9+kf7XJE0arrILTFO/IEA2tQP4SeI0XizZd9WVsOq+CWz/R7eo/W6/QEhu9bg3HOHxjt1wuMFUKybEh7eJDlib2JJAue6fYDhMEsyNuS44fQANWPjRPA8q89Bw43i/ogPBhUBvKfbVqht/OhonMJtskpC5d7ay27CGzHqVNybgOgzUwxp0Mpwo6JutxnQGMWq2j4dFIZ8cyRTFSUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBH0X2zmlz2xDD
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:54:49 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bBGyF2V3Lz1d0sM
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 11:52:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 047FD1402ED
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 11:54:45 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 11:54:44 +0800
Message-ID: <bd08d3de-ba95-4a38-95dc-681e52f48727@huawei.com>
Date: Tue, 3 Jun 2025 11:54:44 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: fix image reproducibility of
 `-E(all-)fragments`
To: <linux-erofs@lists.ozlabs.org>
References: <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
 <20250602170823.1201737-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250602170823.1201737-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/6/3 1:08, Gao Xiang wrote:
> The timestamp of the packed inode should be fixed to the build time.
> 
> Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> change since v1:
>   - fix time assignment (assign `i_mtime_nsec` too) [Hongbo];
> 
>   lib/inode.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo
> diff --git a/lib/inode.c b/lib/inode.c
> index 7a10624..9095ebc 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -910,7 +910,8 @@ out:
>   	return 0;
>   }
>   
> -static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
> +static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
> +					    const char *path)
>   {
>   	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
>   		return true;
> @@ -924,7 +925,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>   		return true;
>   	if (inode->i_nlink > USHRT_MAX)
>   		return true;
> -	if ((inode->i_mtime != inode->sbi->build_time ||
> +	if (path != EROFS_PACKED_INODE &&
> +	    (inode->i_mtime != inode->sbi->build_time ||
>   	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
>   	    !cfg.c_ignore_mtime)
>   		return true;
> @@ -1016,6 +1018,11 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
>   		erofs_err("gid overflow @ %s", path);
>   	inode->i_gid += cfg.c_gid_offset;
>   
> +	if (path == EROFS_PACKED_INODE) {
> +		inode->i_mtime = sbi->build_time;
> +		inode->i_mtime_nsec = sbi->build_time_nsec;
> +		return 0;
> +	}
>   	inode->i_mtime = st->st_mtime;
>   	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
>   
> @@ -1029,7 +1036,6 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
>   	default:
>   		break;
>   	}
> -
>   	return 0;
>   }
>   
> @@ -1065,7 +1071,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
>   	if (!inode->i_srcpath)
>   		return -ENOMEM;
>   
> -	if (erofs_should_use_inode_extended(inode)) {
> +	if (erofs_should_use_inode_extended(inode, path)) {
>   		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
>   			erofs_err("file %s cannot be in compact form",
>   				  inode->i_srcpath);
> @@ -1610,7 +1616,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
>   	erofs_update_progressinfo("Processing %s ...", trimmed);
>   	free(trimmed);
>   
> -	if (erofs_should_use_inode_extended(inode)) {
> +	if (erofs_should_use_inode_extended(inode, inode->i_srcpath)) {
>   		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
>   			erofs_err("file %s cannot be in compact form",
>   				  inode->i_srcpath);

