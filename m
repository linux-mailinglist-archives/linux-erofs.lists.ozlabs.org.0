Return-Path: <linux-erofs+bounces-3145-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKeRIgrey2lHMAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3145-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 16:45:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6E36B24C
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 16:45:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flWBG57Dbz2ybR;
	Wed, 01 Apr 2026 01:45:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774968326;
	cv=none; b=JeXDxBtS26OKc2fAzYPrRQR1zfub0WqYFf/VnqiR2A/uSNguh0TeWg7aKR55mysimFGrG7AuSdUISXsNothnxh9Jrii/1uhARKrvW5EwlmkYH2ObUwXxOSQnwxBxa3CH2fTGcziedcSKop8sZjNwoHyV6mrPgXMNmymlt+JvbMRCKgp4UkYfftVk5tcaJTK3YCc7+a+sEhaVH4rHz14yWJThwVj458LnUufkPlbIlMeCYgNWKDJr5hApahAi7/ha5ZBzSy1wcLF9GJgy6zCMHsf1j8ElEFNBC4aCxgJcXBcR3xtYfVDvVlnYqz2nUtltnoXLT8H0q6F31VrNru2yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774968326; c=relaxed/relaxed;
	bh=L8lUCXpkxX3PqDuQSTwul4U3MPWRvorzFrrFrmLOFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6PF5eMSq9J2zmZQLpFJO7OHNXtsE+CJWd8xAFe/gGHdjcI3udyLa/YQhkPXcSAGNJR8cwI2Mk0waVf5qW8bRDSfwkdldOitjEBQEasPQ549WakV8OvoK2FTTYi4tvmgrd/VRqKrjvrm6mry/YDSvcQPoPxAEn8pNJMgulKkozDs0cI4nn8wghLCqNRgOlS/zGgH+HWHNdgCOwfiQKGLyHUMe0AJWZiml8oD0qMKKw7pmaiocmFnkJ2xH0+rHNldEAuuNVd2WoNcGAmKp3Nu8AlCIhYr/CLZNIeOuLRJyn3DBUNDtEmX0yxuFmE2+k8GxFJ4x9nSIO781eTpMf1+gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CBvBdhob; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CBvBdhob;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flWBD0RNJz2xSb
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 01:45:22 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774968317; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L8lUCXpkxX3PqDuQSTwul4U3MPWRvorzFrrFrmLOFME=;
	b=CBvBdhob4xf3b71O3lYR0oAdsfONNaKKmoO3e+qCflDq/fT09Jl5TjujBLiggXRWqDFHrOFiF6eivQnJcrmRyTmqfmi2bkxrHC3tevTuAyggCbhFeXP1lmyJ2ln5Nxn99GRnLK2NmrU/NwOxwjXFG6y+YAXz7rrdnz+6h+RvigA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X04d3MY_1774968316;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X04d3MY_1774968316 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 22:45:17 +0800
Message-ID: <5dccdd7e-f68f-48a6-b2af-9c8ae4a6ef2e@linux.alibaba.com>
Date: Tue, 31 Mar 2026 22:45:15 +0800
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
Subject: Re: [PATCH v2 2/2] erofs-utils: mount: add fanotify pre-content OCI
 backend
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, zhukeqian1@huawei.com, hudsonzhu@tencent.com
References: <20260330124402.899394-2-zhaoyifan28@huawei.com>
 <20260331131401.901584-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260331131401.901584-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3145-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,man7.org:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 85F6E36B24C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yifan,

On 2026/3/31 21:14, Yifan Zhao wrote:
> Add a fanotify-backed mount mode for OCI sources that uses
> FAN_PRE_ACCESS permission events to populate a local sparse file
> on demand before the kernel consumes the requested data.
> 
> The new erofs.fanotify subtype resolves a single OCI blob,
> creates a sparse cache file, and runs a fanotify event loop
> that fetches missing ranges before allowing access to proceed.
> 
> A pid file recording the canonical mountpoint and sparse-file
> source is written for unmount to track the corresponding worker.
> 
> [ Developed with assistance from GPT-5.4 ]

I will apply this version, but some comments:

It should be marked as:
Assisted-by: AGENT_NAME:GPT-5.4

for example.

> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   configure.ac            |  28 +++
>   lib/Makefile.am         |   7 +
>   lib/backends/fanotify.c | 283 ++++++++++++++++++++++++
>   lib/liberofs_fanotify.h |  59 +++++
>   lib/liberofs_oci.h      |   3 +
>   lib/remotes/oci.c       |  10 +-
>   mount/main.c            | 476 +++++++++++++++++++++++++++++++++++++++-
>   7 files changed, 860 insertions(+), 6 deletions(-)
>   create mode 100644 lib/backends/fanotify.c
>   create mode 100644 lib/liberofs_fanotify.h
> 

...

> +
> +static bool erofs_fanotify_range_in_sparse(int fd, u64 offset, size_t length)
> +{
> +	off_t data_start, hole_start;
> +
> +	data_start = lseek(fd, offset, SEEK_DATA);
> +	if (data_start < 0)
> +		return false;
> +	if ((u64)data_start != offset)
> +		return false;
> +
> +	hole_start = lseek(fd, offset, SEEK_HOLE);
> +	if (hole_start < 0)
> +		return false;
> +	if ((u64)hole_start < offset + length)
> +		return false;

Here I really hope we could switch to bitmaps
instead of relying on holes in the following commits.

> +
> +	return true;
> +}

...

> +
> +static int erofsmount_write_fanotify_state(const char *state_path, pid_t pid,
> +					   const char *mountpoint,
> +					   const char *source)
> +{
> +	struct erofsmount_fanotify_state state;
> +	char *tmp_path = NULL;
> +	FILE *f = NULL;
> +	int fd = -1, err;
> +
> +	if (mkdir(EROFSMOUNT_RUNTIME_DIR, 0700) < 0 && errno != EEXIST)
> +		return -errno;
> +	if (mkdir(EROFSMOUNT_FANOTIFY_STATE_DIR, 0700) < 0 &&
> +	    errno != EEXIST)
> +		return -errno;
> +
> +	state.pid = pid;
> +	state.mountpoint = (char *)mountpoint;
> +	state.source = (char *)source;
> +
> +	if (asprintf(&tmp_path, "%s.tmpXXXXXX", state_path) < 0)
> +		return -ENOMEM;
> +
> +	fd = mkstemp(tmp_path);
> +	if (fd < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	f = fdopen(fd, "w");
> +	if (!f) {
> +		err = -errno;
> +		goto out;
> +	}
> +	fd = -1;
> +
> +	if (fprintf(f, "%d\n%s\n%s\n", state.pid, state.mountpoint,
> +		    state.source) < 0 || fflush(f) == EOF) {

Here, I do think you could identify the mountpoint
using mnt_id (e.g. you could use `mnt_id` as
filename), see statx(2):

https://man7.org/linux/man-pages/man2/statx.2.html
STATX_MNT_ID.

unique mnt_id seems an overkill since we will delete
such files when umounting.

> +		err = errno ? -errno : -EIO;
> +		goto out;

...

> +
> +static int erofsmount_read_fanotify_state(const char *state_path,
> +					  struct erofsmount_fanotify_state *state)
> +{
> +	FILE *f;
> +	size_t n = 0;
> +	int err = 0;
> +
> +	memset(state, 0, sizeof(*state));
> +
> +	f = fopen(state_path, "r");
> +	if (!f)
> +		return -errno;
> +
> +	if (fscanf(f, "%d", &state->pid) != 1)
> +		err = -EINVAL;
> +	else if (fgetc(f) != '\n')
> +		err = -EINVAL;
> +	else if (getline(&state->mountpoint, &n, f) < 0)
> +		err = feof(f) ? -EINVAL : -errno;
> +	else if (getline(&state->source, &n, f) < 0)
> +		err = feof(f) ? -EINVAL : -errno;
> +	fclose(f);
> +	if (err) {
> +		erofsmount_free_fanotify_state(state);
> +		return err;
> +	}
> +
> +	state->mountpoint[strcspn(state->mountpoint, "\n")] = '\0';
> +	state->source[strcspn(state->source, "\n")] = '\0';
> +	return err;
> +}
> +
> +static int erofsmount_cleanup_fanotify_worker(const char *mountpoint,
> +					      const char *source)
> +{
> +	DIR *dir;
> +	struct dirent *de;
> +	int err = 0;
> +
> +	dir = opendir(EROFSMOUNT_FANOTIFY_STATE_DIR);
> +	if (!dir) {
> +		if (errno == ENOENT)
> +			return 0;
> +		return -errno;
> +	}
> +
> +	while ((de = readdir(dir)) != NULL) {
> +		struct erofsmount_fanotify_state state;
> +		char *state_path;
> +
> +		if (strcmp(de->d_name, ".") == 0 || strcmp(de->d_name, "..") == 0)
> +			continue;
> +		if (!strstr(de->d_name, ".state"))
> +			continue;
> +		if (asprintf(&state_path, "%s/%s", EROFSMOUNT_FANOTIFY_STATE_DIR,
> +			     de->d_name) < 0) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +
> +		err = erofsmount_read_fanotify_state(state_path, &state);

same here, so that you don't need readdir() anymore, just
use mnt_id for indexing.
Thanks,
Gao Xiang
>   


