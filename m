Return-Path: <linux-erofs+bounces-2280-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CThF7CjiWlU/wQAu9opvQ
	(envelope-from <linux-erofs+bounces-2280-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Feb 2026 10:06:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A543310D571
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Feb 2026 10:06:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8f2g66MPz2yFm;
	Mon, 09 Feb 2026 20:06:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770628011;
	cv=none; b=UMWV01ZFENcqMhsIlF7hor0bxKYzVAGGPvJ50JZ2kpd9qWcFKdKiVS7hmJPrM1MHuznGNdA/201Odj5d4rOOL/ZWWavfF0cAm90tmln5A2CgfQQi2RNCKj6UQ8OmTe7YYvRHbOhVGJWxUlx8AAeS5AtH+28Sd5JIOM5Q7m2U+fdb7zFWM4FZHgp+SmwLTMczyn6ajo5US9VrAWb4H2lLC0n0ob+PdQSwi1zrqbzKMPSLyS30r2PzfsVyx7njBej+Irl2Drd0zPfkYgfifQN1R/Pp0gHJ3tKR2NRo6cuUJgZl3ucBpoMJRcKP1AOt8tp2iPMSDV8sOaqPN4BAuPe3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770628011; c=relaxed/relaxed;
	bh=pR9W3RvzDKyypVOzgd6y193YEBhKvlWb/mZpsqBFAu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx9EC2CcD6sFGzfSCKQYAXs0x9mkS+YVDX9hTxqsTduN5BESQmY7V4VxI9jEqZQ4ldoc+YolOBu/6hCSdEhch8dxWHT6wnvINITu+S51Or+S6b9dojyu/UoMbo6Jafr4tv+cdK/ypnbUtDISZrNgxag9OrUyUl8G8fuYhDEktgbEDkUP1HlI9UvaM3OplU/LMdgBbuX9Cb5VaHvF1cY9ypzBQ4qeBTSol6LaDa0N7stMczYGq8yy2ANiAvI7DPz3uCxiuGSqV8I37tELJzYe9eXMr/0hiFFhOgHDctWBdomHCDNkVfM+xxizk9ALv/wbLATaWEjwnJ8fnkPb9UVwtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HMmD3j6o; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HMmD3j6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8f2N0XkKz2xc8
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Feb 2026 20:06:33 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770627988; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pR9W3RvzDKyypVOzgd6y193YEBhKvlWb/mZpsqBFAu8=;
	b=HMmD3j6orEfVXa7Etv4kJXX0fpxBng7A7DqwEi7jwctk8o0fWP8fk9mVoEUuL59y+Os2I0Y41EbnjkFkK5Xr7Q8WygppyP/00nz1cJcTYjSdrBAxXAh8L3+ozc12zlCo+baFnTkOodnb6DHh9NXY1kokiL+E9pwSwzcyFd5TMuA=
Received: from 30.221.132.23(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wyq2TjG_1770627985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Feb 2026 17:06:26 +0800
Message-ID: <ba42fa0c-30c7-4754-b910-290899fa0e89@linux.alibaba.com>
Date: Mon, 9 Feb 2026 17:06:25 +0800
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
Subject: Re: [PATCH 1/1] erofs-utils: lib: oci: support reading credentials
 from docker config
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20260209075355.16969-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260209075355.16969-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2280-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hudson@cyzhu.com,m:linux-erofs@lists.ozlabs.org,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A543310D571
X-Rspamd-Action: no action



On 2026/2/9 15:53, ChengyuZhu6 wrote:

..

> --- /dev/null
> +++ b/lib/remotes/docker_config.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +/*
> + * Copyright (C) 2026 Tencent, Inc.
> + *             http://www.tencent.com/
> + */
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#endif
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +
> +#ifdef HAVE_JSON_C_JSON_H
> +#include <json-c/json.h>
> +#endif
> +
> +#include "erofs/defs.h"
> +#include "erofs/print.h"
> +#include "liberofs_base64.h"
> +#include "liberofs_dockerconfig.h"
> +
> +#ifndef HAVE_JSON_C_JSON_H
> +
> +int erofs_docker_config_lookup(const char *registry,
> +			       struct erofs_docker_credential *cred)
> +{
> +	(void)registry;
> +	(void)cred;
> +	return -EOPNOTSUPP;
> +}
> +
> +void erofs_docker_credential_free(struct erofs_docker_credential *cred)
> +{
> +	(void)cred;
> +}
> +
> +#else /* HAVE_JSON_C_JSON_H */
> +
> +static char *docker_config_path(void)
> +{
> +	const char *dir;
> +	char *path = NULL;
> +
> +	dir = getenv("DOCKER_CONFIG");
> +	if (dir && *dir) {
> +		if (asprintf(&path, "%s/config.json", dir) < 0)
> +			return NULL;
> +		return path;
> +	}

Is it possible to make DOCKER_CONFIG as "" to ignore
$HOME/.docker/config.json for script usage?

> +
> +	dir = getenv("HOME");
> +	if (!dir || !*dir) {
> +		erofs_dbg("HOME is not set, cannot locate docker config");
> +		return NULL;
> +	}
> +
> +	if (asprintf(&path, "%s/.docker/config.json", dir) < 0)
> +		return NULL;
> +	return path;
> +}
> +
> +static char *read_file_to_string(const char *path)
> +{
> +	FILE *fp;
> +	struct stat st;
> +	char *buf;
> +	size_t nread;
> +
> +	if (stat(path, &st) < 0)
> +		return NULL;
> +
> +	if (st.st_size <= 0 || st.st_size > (1 << 22))
> +		return NULL;
> +
> +	fp = fopen(path, "r");
> +	if (!fp)
> +		return NULL;
> +
> +	buf = malloc(st.st_size + 1);
> +	if (!buf) {
> +		fclose(fp);
> +		return NULL;
> +	}
> +
> +	nread = fread(buf, 1, st.st_size, fp);
> +	fclose(fp);
> +
> +	if ((off_t)nread != st.st_size) {
> +		free(buf);
> +		return NULL;
> +	}
> +	buf[nread] = '\0';
> +	return buf;
> +}
> +
> +/*
> + * Check if @key (an auths entry key) matches @registry.
> + *
> + * For Docker Hub: @registry is docker.io or registry-1.docker.io.
> + * The auths key in config.json is always "https://index.docker.io/v1/".
> + * For other registries: the auths key is an exact match against @registry.
> + */
> +static bool registry_match(const char *key, const char *registry)
> +{
> +	if (!key || !registry)
> +		return false;
> +
> +	if (!strcasecmp(registry, DOCKER_REGISTRY) ||
> +	    !strcasecmp(registry, DOCKER_API_REGISTRY))
> +		return !strcmp(key, DOCKER_HUB_AUTH_KEY);
> +
> +	return !strcasecmp(key, registry);
> +}
> +
> +static int decode_auth_field(const char *b64, char **out_user, char **out_pass)
> +{
> +	int b64_len = strlen(b64);
> +	int decoded_max = b64_len;
> +	u8 *decoded;
> +	int decoded_len;
> +	char *colon;
> +
> +	decoded = malloc(decoded_max + 1);
> +	if (!decoded)
> +		return -ENOMEM;
> +
> +	decoded_len = erofs_base64_decode(b64, b64_len, decoded);
> +	if (decoded_len <= 0) {
> +		free(decoded);
> +		return -EINVAL;
> +	}
> +	decoded[decoded_len] = '\0';
> +
> +	colon = strchr((char *)decoded, ':');
> +	if (!colon) {
> +		memset(decoded, 0, decoded_len);
> +		free(decoded);
> +		return -EINVAL;
> +	}
> +
> +	*colon = '\0';
> +	*out_user = strdup((char *)decoded);
> +	*out_pass = strdup(colon + 1);
> +
> +	memset(decoded, 0, decoded_len);
> +	free(decoded);
> +
> +	if (!*out_user || !*out_pass) {
> +		free(*out_user);
> +		free(*out_pass);
> +		*out_user = NULL;
> +		*out_pass = NULL;
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +int erofs_docker_config_lookup(const char *registry,
> +			       struct erofs_docker_credential *cred)
> +{
> +	char *path = NULL;
> +	char *content = NULL;
> +	struct json_object *root = NULL, *auths_obj = NULL;
> +	int ret = -ENOENT;
> +
> +	memset(cred, 0, sizeof(*cred));
> +
> +	path = docker_config_path();
> +	if (!path)
> +		return -ENOENT;
> +
> +	content = read_file_to_string(path);
> +	if (!content) {
> +		erofs_dbg("cannot read docker config: %s", path);
> +		free(path);
> +		return -ENOENT;
> +	}
> +	free(path);
> +
> +	root = json_tokener_parse(content);
> +	memset(content, 0, strlen(content));
> +	free(content);
> +
> +	if (!root) {
> +		erofs_warn("failed to parse docker config.json");
> +		return -EINVAL;
> +	}
> +
> +	if (!json_object_object_get_ex(root, "auths", &auths_obj)) {
> +		erofs_dbg("no \"auths\" in docker config.json");
> +		json_object_put(root);
> +		return -ENOENT;
> +	}
> +
> +	struct json_object_iterator it = json_object_iter_begin(auths_obj);
> +	struct json_object_iterator end = json_object_iter_end(auths_obj);
> +
> +	while (!json_object_iter_equal(&it, &end)) {
> +		const char *key = json_object_iter_peek_name(&it);
> +		struct json_object *entry, *auth_field;
> +		const char *b64;
> +
> +		if (!registry_match(key, registry)) {
> +			json_object_iter_next(&it);
> +			continue;
> +		}
> +
> +		entry = json_object_iter_peek_value(&it);
> +		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
> +			b64 = json_object_get_string(auth_field);
> +			if (b64 && *b64) {
> +				ret = decode_auth_field(b64, &cred->username,
> +							&cred->password);
> +				if (!ret)
> +					erofs_dbg("found docker credentials for %s",
> +						  registry);
> +			}
> +		}
> +		break;
> +	}
> +
> +	json_object_put(root);
> +	return ret;
> +}
> +
> +void erofs_docker_credential_free(struct erofs_docker_credential *cred)
> +{
> +	if (cred->username) {
> +		memset(cred->username, 0, strlen(cred->username));
> +		free(cred->username);
> +		cred->username = NULL;
> +	}
> +	if (cred->password) {
> +		memset(cred->password, 0, strlen(cred->password));
> +		free(cred->password);
> +		cred->password = NULL;
> +	}

maybe introduce erofs_free_sensitive() for these usage.

Thanks,
Gao Xiang

