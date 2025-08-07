Return-Path: <linux-erofs+bounces-784-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F2B1D144
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Aug 2025 05:36:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byCWr1jKxz30VV;
	Thu,  7 Aug 2025 13:36:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754537816;
	cv=none; b=AqKSnOj7uhNCL76HCMJLD9Kekeq7jMAYKbI5BqrsxU1dTg3T4CGkGomnLhXyulDMONzCZJlJWvaxZ84VHBB93OMtbJt6PIe4nhDX0kT4p76iBVBXfdPgveLp2Us0wdI0fwC++BoqkKVEkDbPSy8HfjQwRaQttyruHWLIedwZ5KmO79jVXonhZp/nnGqscBN4tcntWG4kDYT9Hju7ENqnhqXuM3Ihqky2RaaGeMqcOGcThtqMmPT/dFOACiqahT9s0x820OGI5nMpM+yaMN5JLEbc6rN0W3qh5xk7HupYSt8fIncEPLMMOso+3CJ6jYj0JCrsJauzzygK4e3ekNms3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754537816; c=relaxed/relaxed;
	bh=jmggACfaLWF6wcvuLYlHd1KRlZT5MEDaBiK+nJ4Gl38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QHTEkYzt6S7ViJkLlWyfONDnyic3XApkgF2Q2gFhd/bxyp4iVxKz0qZQ7KCAIqQ2e5shsu2e0X3/MOD1iTPeat8+yTJblnUkbNEqnE6HybzEsu5A1euiiRFwGPvDh5Fd6fwFcLAWSVFtZ0avsA8WpGgTs+gv/8XUZ9bZr8UUELVDKluKOO5+4sp449dZebBMotr6powTgrhxqa/kg8nMj4ylCA3h1TnajLVj1ONGRYqO59xYeur2XgRWE9nR16pZSP/vMhy2LeN9OlgMZbrTr4bXQX7LfHuRhkKSzDBryG8sesVyfMh6w3014MuP2qlqBuesV7NM6dhKwjr2OtOEtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byCWp6cS8z30RJ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Aug 2025 13:36:52 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4byCQj2PfPz14MJQ;
	Thu,  7 Aug 2025 11:32:29 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B0C01400DC;
	Thu,  7 Aug 2025 11:36:46 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 11:36:45 +0800
Message-ID: <349197b9-c9c5-41db-b861-4ae479ef7e33@huawei.com>
Date: Thu, 7 Aug 2025 11:36:45 +0800
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
Subject: Re: [PATCH v6 1/4] erofs-utils: mkfs: introduce source_mode
 enumeration
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250807030835.2671337-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250807030835.2671337-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/7 11:08, Gao Xiang wrote:
> From: Yifan Zhao <zhaoyifan28@huawei.com>
> 
> Currently, mkfs controls different image build execution flows through
> the global variables `tar_mode` and `rebuild_mode`, while these two
> modes together with localdir mode are mutually exclusive.
> 
> Let's replace them with a new variable `source_mode` to simplify the
> logic.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

> ---
>   mkfs/main.c | 78 ++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 44 insertions(+), 34 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index dc2df06..ab27b77 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -244,7 +244,7 @@ static int pclustersize_metabox = -1;
>   static struct erofs_tarfile erofstar = {
>   	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
>   };
> -static bool tar_mode, rebuild_mode, incremental_mode;
> +static bool incremental_mode;
>   static u8 metabox_algorithmid;
>   
>   enum {
> @@ -254,6 +254,12 @@ enum {
>   	EROFS_MKFS_DATA_IMPORT_SPARSE,
>   } dataimport_mode;
>   
> +static enum {
> +	EROFS_MKFS_SOURCE_LOCALDIR,
> +	EROFS_MKFS_SOURCE_TAR,
> +	EROFS_MKFS_SOURCE_REBUILD,
> +} source_mode;
> +
>   static unsigned int rebuild_src_count, total_ccfgs;
>   static LIST_HEAD(rebuild_src_list);
>   static u8 fixeduuid[16];
> @@ -499,7 +505,7 @@ static void mkfs_parse_tar_cfg(char *cfg)
>   {
>   	char *p;
>   
> -	tar_mode = true;
> +	source_mode = EROFS_MKFS_SOURCE_TAR;
>   	if (!cfg)
>   		return;
>   	p = strchr(cfg, ',');
> @@ -616,7 +622,30 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
>   	int err, fd;
>   	char *s;
>   
> -	if (tar_mode) {
> +	switch (source_mode) {
> +	case EROFS_MKFS_SOURCE_LOCALDIR:
> +		err = lstat((s = argv[optind++]), &st);
> +		if (err) {
> +			erofs_err("failed to stat %s: %s", s,
> +				  erofs_strerror(-errno));
> +			return -ENOENT;
> +		}
> +		if (S_ISDIR(st.st_mode)) {
> +			cfg.c_src_path = realpath(s, NULL);
> +			if (!cfg.c_src_path) {
> +				erofs_err("failed to parse source directory: %s",
> +					  erofs_strerror(-errno));
> +				return -ENOENT;
> +			}
> +			erofs_set_fs_root(cfg.c_src_path);
> +		} else {
> +			cfg.c_src_path = strdup(s);
> +			if (!cfg.c_src_path)
> +				return -ENOMEM;
> +			source_mode = EROFS_MKFS_SOURCE_REBUILD;
> +		}
> +		break;
> +	case EROFS_MKFS_SOURCE_TAR:
>   		cfg.c_src_path = strdup(argv[optind++]);
>   		if (!cfg.c_src_path)
>   			return -ENOMEM;
> @@ -640,30 +669,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
>   			}
>   			erofstar.ios.dumpfd = fd;
>   		}
> -	} else {
> -		err = lstat((s = argv[optind++]), &st);
> -		if (err) {
> -			erofs_err("failed to stat %s: %s", s,
> -				  erofs_strerror(-errno));
> -			return -ENOENT;
> -		}
> -		if (S_ISDIR(st.st_mode)) {
> -			cfg.c_src_path = realpath(s, NULL);
> -			if (!cfg.c_src_path) {
> -				erofs_err("failed to parse source directory: %s",
> -					  erofs_strerror(-errno));
> -				return -ENOENT;
> -			}
> -			erofs_set_fs_root(cfg.c_src_path);
> -		} else {
> -			cfg.c_src_path = strdup(s);
> -			if (!cfg.c_src_path)
> -				return -ENOMEM;
> -			rebuild_mode = true;
> -		}
> +		break;
> +	default:
> +		erofs_err("unexpected source_mode: %d", source_mode);
> +		return -EINVAL;
>   	}
>   
> -	if (rebuild_mode) {
> +	if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
>   		char *srcpath = cfg.c_src_path;
>   		struct erofs_sb_info *src;
>   
> @@ -1083,7 +1095,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   		err = mkfs_parse_sources(argc, argv, optind);
>   		if (err)
>   			return err;
> -	} else if (!tar_mode) {
> +	} else if (source_mode != EROFS_MKFS_SOURCE_TAR) {
>   		erofs_err("missing argument: SOURCE(s)");
>   		return -EINVAL;
>   	} else {
> @@ -1383,7 +1395,7 @@ int main(int argc, char **argv)
>   	if (cfg.c_random_pclusterblks)
>   		srand(time(NULL));
>   #endif
> -	if (tar_mode) {
> +	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
>   		if (dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
>   			erofstar.rvsp_mode = true;
>   		erofstar.dev = rebuild_src_count + 1;
> @@ -1403,9 +1415,7 @@ int main(int argc, char **argv)
>   			g_sbi.blkszbits = 9;
>   			tar_index_512b = true;
>   		}
> -	}
> -
> -	if (rebuild_mode) {
> +	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
>   		struct erofs_sb_info *src;
>   
>   		erofs_warn("EXPERIMENTAL rebuild mode in use. Use at your own risk!");
> @@ -1465,7 +1475,7 @@ int main(int argc, char **argv)
>   	else if (!incremental_mode)
>   		erofs_uuid_generate(g_sbi.uuid);
>   
> -	if (tar_mode && !erofstar.index_mode) {
> +	if (source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) {
>   		err = erofs_diskbuf_init(1);
>   		if (err) {
>   			erofs_err("failed to initialize diskbuf: %s",
> @@ -1528,7 +1538,7 @@ int main(int argc, char **argv)
>   
>   	erofs_inode_manager_init();
>   
> -	if (tar_mode) {
> +	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
>   		root = erofs_rebuild_make_root(&g_sbi);
>   		if (IS_ERR(root)) {
>   			err = PTR_ERR(root);
> @@ -1543,7 +1553,7 @@ int main(int argc, char **argv)
>   		err = erofs_rebuild_dump_tree(root, incremental_mode);
>   		if (err < 0)
>   			goto exit;
> -	} else if (rebuild_mode) {
> +	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
>   		root = erofs_rebuild_make_root(&g_sbi);
>   		if (IS_ERR(root)) {
>   			err = PTR_ERR(root);
> @@ -1663,7 +1673,7 @@ exit:
>   	erofs_rebuild_cleanup();
>   	erofs_diskbuf_exit();
>   	erofs_exit_configure();
> -	if (tar_mode) {
> +	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
>   		erofs_iostream_close(&erofstar.ios);
>   		if (erofstar.ios.dumpfd >= 0)
>   			close(erofstar.ios.dumpfd);

