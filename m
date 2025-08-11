Return-Path: <linux-erofs+bounces-812-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF4B1FEF8
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Aug 2025 08:06:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0kfv00p2z3ccl;
	Mon, 11 Aug 2025 16:06:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754892406;
	cv=none; b=PZ23AU+RmWq+UM/dQvEVPZfbfLSL0FyTnJy86uY0lQH7C4DrVCbQhuOIleu6AMeR94pBirRVlL5lmoqpmffxF/APUaMHG2t4CCleLC10LpB6P/4OuSDa8X5JnAPr0pKAdK0nya9ZA2LFReoxgBrFKu/d1RCW1VgzowyujSDsWBw6Yn/Pq4lixHuw6t+D3RoIssVk727Du+OPebzp4GEld8JZ3aNeF/q3bvLu9HnBGRgyte0yZskIFFAWe7jgEIctNqVgasobA8eopD35o7zc4sor13sY66M6HbY2a9eFZLiPtWmOQPnhI5uPScQmw9e0tZIIAO1ZgaVa3wIgENLVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754892406; c=relaxed/relaxed;
	bh=7L4qzGXKU/HVCNvzixAdnOdUMmIjmLcwc66VMGGevXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lyss2nrfMx8YVnG5DCDlGMJNxUc/hsQ2hA1YCAHg4j/MsC1lDDDB+4NczpleGl3/vOHr/5E2+2wQaPk2rlv5qr76KtAErKpGVoNp9hzaPPrUEkPekVUUr9IP37OVexSO5jczVw94EwlVSZYikNsE0PDnb4kwMPVynNiJZrfAN+F9UWE5oafXEt/q9dnhlWTRpHdT6eRYYba0Lv2oAwOnuYoCgZFqT/5odHsTHlbKT6ms4of0dJAJ6eeEa/nuQ1+GN+JAAbw7xLkkIFM40Qc1CljqTvZERRNXu+wNL0Oxf7v6tmczlI8cov2DH6aCRIFcIA2ZXaqyndozVGHWNEVlYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0kfr6V0wz3ccV
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Aug 2025 16:06:42 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c0kbP4NM9z1R8xb;
	Mon, 11 Aug 2025 14:03:45 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 9490D1402C1;
	Mon, 11 Aug 2025 14:06:34 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 14:06:34 +0800
Message-ID: <c2cbb376-6425-489d-ad68-dc1b2bed66b7@huawei.com>
Date: Mon, 11 Aug 2025 14:06:33 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: support full image generation from
 S3
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250809143350.3010270-1-hsiangkao@linux.alibaba.com>
 <20250811015910.1446727-1-hsiangkao@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20250811015910.1446727-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Tested with urlstyle=path in huaweicloud OBS.


Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>


Thanks,

Yifan Zhao

On 2025/8/11 9:59, Gao Xiang wrote:
> Preliminary implementation without multipart downloading.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>   - fix compile error due to undefined EROFS_MKFS_SOURCE_S3.
>
>   lib/liberofs_s3.h |   2 +-
>   lib/remotes/s3.c  | 119 ++++++++++++++++++++++++++++++++++++++++++----
>   mkfs/main.c       |  10 ++--
>   3 files changed, 115 insertions(+), 16 deletions(-)
>
> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
> index 4ac03d5..27b041c 100644
> --- a/lib/liberofs_s3.h
> +++ b/lib/liberofs_s3.h
> @@ -34,7 +34,7 @@ struct erofs_s3 {
>   };
>   
>   int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
> -			const char *path);
> +			const char *path, bool fillzero);
>   
>   #ifdef __cplusplus
>   }
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index 46fba6b..1497b54 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -15,6 +15,7 @@
>   #include "erofs/print.h"
>   #include "erofs/inode.h"
>   #include "erofs/blobchunk.h"
> +#include "erofs/diskbuf.h"
>   #include "erofs/rebuild.h"
>   #include "liberofs_s3.h"
>   
> @@ -41,7 +42,7 @@ struct s3erofs_curl_request {
>   
>   static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
>   			       const char *endpoint,
> -			       const char *path,
> +			       const char *path, const char *key,
>   			       struct s3erofs_query_params *params,
>   			       enum s3erofs_url_style url_style)
>   {
> @@ -81,8 +82,14 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
>   				       host, split);
>   		}
>   	}
> +	if (key) {
> +		slash |= url[pos - 1] != '/';
> +		pos -= !slash;
> +		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
> +	}
> +
>   	i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
> -		     "/%s%s", path, slash ? "/" : "");
> +		     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
>   	req->canonical_query[i] = '\0';
>   
>   	for (i = 0; i < params->num; i++)
> @@ -91,6 +98,7 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
>   				params->key[i], params->value[i]);
>   	if (schema != https)
>   		free((void *)schema);
> +	erofs_dbg("Request URL %s", url);
>   	return 0;
>   }
>   
> @@ -460,11 +468,15 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
>   	}
>   
>   	req.method = "GET";
> -	ret = s3erofs_prepare_url(&req, s3->endpoint, it->bucket,
> +	ret = s3erofs_prepare_url(&req, s3->endpoint, it->bucket, NULL,
>   				  &params, s3->url_style);
>   	if (ret < 0)
>   		return ret;
>   
> +	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
> +			     s3erofs_request_write_memory_cb) != CURLE_OK)
> +		return -EIO;
> +
>   	ret = s3erofs_request_perform(s3, &req, &resp);
>   	if (ret < 0)
>   		return ret;
> @@ -544,14 +556,10 @@ static int s3erofs_global_init(void)
>   	if (!easy_curl)
>   		goto out_err;
>   
> -	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
> -			     s3erofs_request_write_memory_cb) != CURLE_OK)
> -		goto out_err;
> -
>   	if (curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
>   		goto out_err;
>   
> -	if (curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L) != CURLE_OK)
> +	if (curl_easy_setopt(easy_curl, CURLOPT_CONNECTTIMEOUT, 30L) != CURLE_OK)
>   		goto out_err;
>   
>   	if (curl_easy_setopt(easy_curl, CURLOPT_USERAGENT,
> @@ -578,8 +586,95 @@ static void s3erofs_global_exit(void)
>   	curl_global_cleanup();
>   }
>   
> +struct s3erofs_curl_getobject_resp {
> +	struct erofs_vfile *vf;
> +	erofs_off_t pos, end;
> +};
> +
> +static size_t s3erofs_remote_getobject_cb(void *contents, size_t size,
> +					  size_t nmemb, void *userp)
> +{
> +	struct s3erofs_curl_getobject_resp *resp = userp;
> +	size_t realsize = size * nmemb;
> +
> +	if (resp->pos + realsize > resp->end ||
> +	    erofs_io_pwrite(resp->vf, contents, resp->pos, realsize) != realsize)
> +		return 0;
> +
> +	resp->pos += realsize;
> +	return realsize;
> +}
> +
> +static int s3erofs_remote_getobject(struct erofs_s3 *s3,
> +				    struct erofs_inode *inode,
> +				    const char *bucket, const char *key)
> +{
> +	struct erofs_sb_info *sbi = inode->sbi;
> +	struct s3erofs_curl_request req = {};
> +	struct s3erofs_curl_getobject_resp resp;
> +	struct s3erofs_query_params params;
> +	struct erofs_vfile vf;
> +	int ret;
> +
> +	params.num = 0;
> +	req.method = "GET";
> +	ret = s3erofs_prepare_url(&req, s3->endpoint, bucket, key,
> +				  &params, s3->url_style);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
> +			     s3erofs_remote_getobject_cb) != CURLE_OK)
> +		return -EIO;
> +
> +	resp.pos = 0;
> +	if (!cfg.c_compr_opts[0].alg && !cfg.c_inline_data) {
> +		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> +		inode->idata_size = 0;
> +		ret = erofs_allocate_inode_bh_data(inode,
> +				DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits));
> +		if (ret)
> +			return ret;
> +		resp.vf = &sbi->bdev;
> +		resp.pos = erofs_pos(inode->sbi, inode->u.i_blkaddr);
> +		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
> +	} else {
> +		u64 off;
> +
> +		if (!inode->i_diskbuf) {
> +			inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
> +			if (!inode->i_diskbuf)
> +				return -ENOSPC;
> +		} else {
> +			erofs_diskbuf_close(inode->i_diskbuf);
> +		}
> +
> +		vf = (struct erofs_vfile) {.fd =
> +			erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off)};
> +		if (vf.fd < 0)
> +			return -EBADF;
> +		resp.pos = off;
> +		resp.vf = &vf;
> +		inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
> +	}
> +	resp.end = resp.pos + inode->i_size;
> +
> +	ret = s3erofs_request_perform(s3, &req, &resp);
> +	if (resp.vf == &vf) {
> +		erofs_diskbuf_commit(inode->i_diskbuf, resp.end - resp.pos);
> +		if (ret) {
> +			erofs_diskbuf_close(inode->i_diskbuf);
> +			inode->i_diskbuf = NULL;
> +			inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
> +		}
> +	}
> +	if (ret)
> +		return ret;
> +	return resp.pos != resp.end ? -EIO : 0;
> +}
> +
>   int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
> -			const char *path)
> +			const char *path, bool fillzero)
>   {
>   	struct erofs_sb_info *sbi = root->sbi;
>   	struct s3erofs_object_iterator *iter;
> @@ -656,7 +751,11 @@ int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
>   		ret = __erofs_fill_inode(inode, &st, obj->key);
>   		if (!ret && S_ISREG(inode->i_mode)) {
>   			inode->i_size = obj->size;
> -			ret = erofs_write_zero_inode(inode);
> +			if (fillzero)
> +				ret = erofs_write_zero_inode(inode);
> +			else
> +				ret = s3erofs_remote_getobject(s3, inode,
> +						iter->bucket, obj->key);
>   		}
>   		if (ret)
>   			goto err_iter;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d3bd1cd..804d483 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -271,9 +271,7 @@ enum {
>   static enum {
>   	EROFS_MKFS_SOURCE_LOCALDIR,
>   	EROFS_MKFS_SOURCE_TAR,
> -#ifdef S3EROFS_ENABLED
>   	EROFS_MKFS_SOURCE_S3,
> -#endif
>   	EROFS_MKFS_SOURCE_REBUILD,
>   } source_mode;
>   
> @@ -1639,7 +1637,8 @@ int main(int argc, char **argv)
>   	else if (!incremental_mode)
>   		erofs_uuid_generate(g_sbi.uuid);
>   
> -	if (source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) {
> +	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
> +	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
>   		err = erofs_diskbuf_init(1);
>   		if (err) {
>   			erofs_err("failed to initialize diskbuf: %s",
> @@ -1749,11 +1748,12 @@ int main(int argc, char **argv)
>   			}
>   
>   			if (incremental_mode ||
> -			    dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL)
> +			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
>   				err = -EOPNOTSUPP;
>   			else
>   				err = s3erofs_build_trees(root, &s3cfg,
> -							  cfg.c_src_path);
> +							  cfg.c_src_path,
> +					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
>   			if (err)
>   				goto exit;
>   #endif

