Return-Path: <linux-erofs+bounces-991-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB4B4A5CB
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 10:46:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLcql2sm0z30Vl;
	Tue,  9 Sep 2025 18:46:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757407587;
	cv=none; b=dMY5X4KlkJgeGsliPNuWWmpqDUJKKiU/NmIyQhTpyoSCam3J+ddjlaSNV8nHnxfMWGcKB9nt/DlDuaP6VVL52oAw2Zu684SmrTjnOw+OGyK1Axz3e9UhoqTTIQCduINReTsdBcBVtSqeJL1l4AiH7g78GynPdCdEfhicgEKAdO/eAO/Csfoer2CgnLcOdwLfjbXt4ufqryIHLpr80GU6BhHTsHaxkaCEdX1fKfXIgXb8Hfsm5ZxuJ3vj70RBpheeKF32RNCzOzI2B1C72jj3ZtWOl7COfCH/hCh5E4aoz9pz3rtikWonYnx+ATqlQPIhOySxHjX599tcmgbDboInlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757407587; c=relaxed/relaxed;
	bh=fQbvoo8e8rHF1FTS8zMauPgGPWKRksB3jZq/0jGyh2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da/J08MME6TvwO0kbvMGRJERWOU+2lkcHUjF7uEbyGIZU9cfFHEuMVwDprnu6gwtfd9nWWaSItYekL5KWgKdQyAQCHEHwfjKTcmKZgpcDg6EfeET5wbFydGhQckMfNhCZyobt5dROy8ps3WVtgKHR9y1i7ZGn6E5UacBpk7I6VRLuWmf9tRzyN1ZaTVMvC+WSQO1BkY8I7MLQpa4B7HEpAd3hfYOH7s5v5o7F3oqq7ttKb8xL0wIOeCO/K/aafNpXNbRk8qwvlJ2JhRUjG2dRnbyjfhpvlR1Hvl7f7Pdgb7khZEfkIaFW/PjdK1SmmOq66RAoi80Gf5+lt5EOtj8uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jBgJQf7L; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jBgJQf7L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLcqh4Ywmz30V1
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 18:46:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757407579; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fQbvoo8e8rHF1FTS8zMauPgGPWKRksB3jZq/0jGyh2A=;
	b=jBgJQf7L8yekdFI7HKnN+cg5XPxMaZuf2dFt9OwBw+Sngr/oukimbrEyj8w9PStCvGAE6bwnqC0YAkESLl1NdweLsDcA3yShhaupGoJr5sWYZyHYawnrGdw27gxo8XbhUO3lw5Tdy1mx9MPQgEM+4WyqaDVRnIvoqm9JCv/crNU=
Received: from 30.221.131.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WndCykf_1757407576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 16:46:17 +0800
Message-ID: <822ebea6-f7de-41f2-aab0-ef3d6a781efe@linux.alibaba.com>
Date: Tue, 9 Sep 2025 16:46:16 +0800
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
Subject: Re: [PATCH v1] erofs-utils:mount: add OCI recovery support for NBD
 reattach
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250909070909.83921-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250909070909.83921-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/9 15:09, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This commit implements recovery support for OCI-based NBD mounts,
> allowing the system to properly reattach NBD devices after
> NBD disconnection.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   mount/main.c | 100 ++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 75 insertions(+), 25 deletions(-)
> 
> diff --git a/mount/main.c b/mount/main.c
> index c52ac3b..37e9f6d 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -401,12 +401,14 @@ out_closefd:
>   	return err;
>   }
>   
> -static char *erofsmount_write_recovery_info(const char *source)
> +static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
>   {
>   	char recp[] = "/var/run/erofs/mountnbd_XXXXXX";
>   	char *realp;
>   	int fd, err;
>   	FILE *f;
> +	char *content = NULL;
> +	int ret;
>   
>   	fd = mkstemp(recp);
>   	if (fd < 0 && errno == ENOENT) {
> @@ -424,15 +426,32 @@ static char *erofsmount_write_recovery_info(const char *source)
>   		return ERR_PTR(-errno);
>   	}
>   
> -	realp = realpath(source, NULL);
> -	if (!realp) {
> -		fclose(f);
> -		return ERR_PTR(-errno);
> +	if (source->type == EROFSNBD_SOURCE_OCI) {

Could we just split this block into:
	erofsmount_write_recovery_oci(f, source);

> +		ret = asprintf(&content, "%s %s %s %s %d",
> +			       source->ocicfg.image_ref ?: "",
> +			       source->ocicfg.platform ?: "",
> +			       source->ocicfg.username ?: "",
> +			       source->ocicfg.password ?: "",

Could we just encode username:password into base64?

> +			       source->ocicfg.layer_index);
> +		if (ret < 0) {
> +			fclose(f);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		err = fprintf(f, "OCI_LAYER %s\n", content) < 0;
> +		free(content);
> +	} else {

and this into:
	erofsmount_write_recovery_local(f, source);

> +		realp = realpath(source->device_path, NULL);
> +		if (!realp) {
> +			fclose(f);
> +			return ERR_PTR(-errno);
> +		}
> +
> +		/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
> +		err = fprintf(f, "LOCAL %s\n", realp) < 0;
> +		free(realp);
>   	}
> -	/* TYPE<LOCAL> <SOURCE PATH>\n(more..) */
> -	err = fprintf(f, "LOCAL %s\n", realp) < 0;
> +
>   	fclose(f);
> -	free(realp);
>   	if (err)
>   		return ERR_PTR(-ENOMEM);
>   	return strdup(recp) ?: ERR_PTR(-ENOMEM);
> @@ -491,15 +510,10 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofs_nbd_source *source)
>   				exit(EXIT_FAILURE);
>   			ctx.vd.fd = err;
>   		}
> -
> -		if (source->type == EROFSNBD_SOURCE_LOCAL) {
> -			recp = erofsmount_write_recovery_info(source->device_path);
> -			if (IS_ERR(recp)) {
> -				erofs_io_close(&ctx.vd);
> -				exit(EXIT_FAILURE);
> -			}
> -		} else {
> -			recp = NULL;
> +		recp = erofsmount_write_recovery_info(source);
> +		if (IS_ERR(recp)) {
> +			erofs_io_close(&ctx.vd);
> +			exit(EXIT_FAILURE);
>   		}
>   
>   		num = -1;
> @@ -595,19 +609,55 @@ static int erofsmount_reattach(const char *target)
>   		*(source++) = '\0';
>   	}
>   
> -	if (strcmp(line, "LOCAL")) {
> +	if (!strcmp(line, "LOCAL")) {
> +		err = open(source, O_RDONLY);
> +		if (err < 0) {
> +			err = -errno;
> +			goto err_line;
> +		}
> +		ctx.vd.fd = err;
> +	} else if (!strcmp(line, "OCI_LAYER")) {
> +		struct ocierofs_config oci_cfg = {};
> +		char *platform, *username, *password, *layer_str;
> +		int layer_index;
> +
> +		platform = strchr(source, ' ');
> +		if (platform) {
> +			*platform++ = '\0';
> +			oci_cfg.image_ref = source;
> +			oci_cfg.platform = platform;
> +		} else {
> +			oci_cfg.image_ref = source;
> +		}
> +
> +		username = strchr(platform ?: source, ' ');
> +		if (username) {
> +			*username++ = '\0';
> +			oci_cfg.username = username;
> +		}
> +
> +		password = strchr(username ?: (platform ?: source), ' ');
> +		if (password) {
> +			*password++ = '\0';
> +			oci_cfg.password = password;
> +		}
> +
> +		layer_str = strchr(password ?: (username ?: (platform ?: source)), ' ');
> +		if (layer_str) {
> +			*layer_str++ = '\0';
> +			layer_index = atoi(layer_str);
> +			oci_cfg.layer_index = layer_index;
> +		}

Move those into erofsmount_parse_recovery_ocilayer(&oci_cfg, source)?

Thanks,
Gao Xiang

