Return-Path: <linux-erofs+bounces-3228-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VeTBCc8o12m8LAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3228-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 06:19:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3413C62C0
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 06:19:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frmsk31kqz2ySj;
	Thu, 09 Apr 2026 14:19:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775708362;
	cv=none; b=jg+p76bAkzpd9HXbR4/ZpO7iWIzwGCHxbEwpv94TTQhAaYUKTlKwjATo9HEpQHYN0Oc0CeEHpa0qU7LabLXhf41JblCZUbEVM17wVlZ0nJeF5qOBJ3f0arpvArnSo96MQy+3yn4kPuvioi0BC/hRVVmQair+O9XWElXbVkDfD8Ux9d90YSVKKDvH79ihsJDyLNqYC5UqCl0uHYgytEjqt/e4oFbA6GGm2KJ/3eyPn06wZl1cUq/aoJdmky25gaGrCvWwPvPQsnyUXja5LPAFdM1G+JPZg8UHuUXyPyRD2JrmPA3rZFX0X+8EoHfrJUQdRJjB2l+z6iBGjbtQXRsbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775708362; c=relaxed/relaxed;
	bh=NtxFzRHhPFnoRZ3fweTihTDcGJAy6GcvFMgSm2SPQ8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiuyKPyR9VObLItQo2lkcyWqm7SDNAgJ0lO/6yO/pyOwmJM7NfxfICoBLfQl/gQV1YfKndoEljBdAhxuDvgmxeZul/XRj/3m06nYiM9AjQer8xwxxY2482Z/w+c/drDC9E5i46THQeg8HDZy1NaKKpcktcgpN7JnyseDR5cDMDr90+6DchFlu/L+9gzjpYmyXBaeawqnxqbxVstvv7wjyeq4nuV6sDp8S0KeKHeCAfGDtoATKEoEDTVTjH2NMi2p3guQtcyuGEu+qx+hrj7EajPbUSXM3c4eRxjwIto2grDX8r1EKHTpgStp3NMFJvy4gNLukAYR4gGB9+TKAvcU6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E0dl5H6c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E0dl5H6c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frmsg1qJvz2ySc
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 14:19:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775708352; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NtxFzRHhPFnoRZ3fweTihTDcGJAy6GcvFMgSm2SPQ8M=;
	b=E0dl5H6cCmG/F5WKe7pvYMWswOnf27hHloL+IO3j4/hwpE01VA994qVFeC86lFBEX/x+1ylt8Kz/zjEuyms9YCIuhF+qYezGSvqcUvlASEa/aNuWZfPEJ2CUurYhYcSLA+AnYjgxr0KEsO4NeQgkJXtX+p6+DJPedJSWx7k6Rtk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X0h8L38_1775708349;
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0h8L38_1775708349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 12:19:10 +0800
Message-ID: <48e31164-920a-40d1-b509-be5cfb1591cc@linux.alibaba.com>
Date: Thu, 9 Apr 2026 12:19:09 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: mount: gracefully handle long-lived
 backend workers
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, zhukeqian1@huawei.com
References: <20260403064230.914563-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260403064230.914563-1-zhaoyifan28@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-3228-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email]
X-Rspamd-Queue-Id: 3B3413C62C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yifan,

On 2026/4/3 14:42, Yifan Zhao wrote:
> Currently long-lived backend workers were created with a bare fork() and
> kept running with the caller's process context. They still inherited
> CLI-oriented session and stdio, making the background worker fragile.
> 
> Refine the worker setup used by the NBD and fanotify mount paths so
> forked children behave like well-formed long-lived background processes.
> 
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   mount/main.c | 208 ++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 156 insertions(+), 52 deletions(-)
> 
> diff --git a/mount/main.c b/mount/main.c
> index e09e585..45ac32e 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -98,6 +98,75 @@ static struct erofsmount_source {
>   	};
>   } mountsrc;
>   
> +static int erofsmount_spawn_worker(pid_t *pid)
> +{
> +	*pid = fork();
> +	if (*pid < 0)
> +		return -errno;
> +	return *pid;
> +}

I think this helper is not useful, let's just open-coded it.

> +
> +static int erofsmount_worker_set_signal(int signum, sighandler_t handler)
> +{
> +	struct sigaction act = {
> +		.sa_handler = handler,
> +	};
> +
> +	if (sigemptyset(&act.sa_mask) < 0)
> +		return -errno;
> +	if (sigaction(signum, &act, NULL) < 0)
> +		return -errno;
> +	return 0;
> +}
> +
> +static int erofsmount_worker_detach(void)
> +{
> +	sigset_t mask;
> +	int fd, err;
> +
> +	if (setsid() < 0)
> +		return -errno;
> +
> +	if (sigemptyset(&mask) < 0)
> +		return -errno;
> +	if (sigprocmask(SIG_SETMASK, &mask, NULL) < 0)
> +		return -errno;
> +
> +	err = erofsmount_worker_set_signal(SIGHUP, SIG_DFL);
> +	if (err)
> +		return err;
> +	err = erofsmount_worker_set_signal(SIGINT, SIG_DFL);
> +	if (err)
> +		return err;
> +	err = erofsmount_worker_set_signal(SIGQUIT, SIG_DFL);
> +	if (err)
> +		return err;
> +	err = erofsmount_worker_set_signal(SIGTERM, SIG_DFL);
> +	if (err)
> +		return err;
> +	err = erofsmount_worker_set_signal(SIGPIPE, SIG_IGN);
> +	if (err)
> +		return err;
> +
> +	fd = open("/dev/null", O_RDWR);
> +	if (fd < 0)
> +		return -errno;
> +	if (dup2(fd, STDIN_FILENO) < 0 || dup2(fd, STDOUT_FILENO) < 0 ||
> +	    dup2(fd, STDERR_FILENO) < 0) {
> +		err = -errno;
> +		close(fd);
> +		return err;
> +	}
> +	if (fd > STDERR_FILENO)
> +		close(fd);
> +	return 0;
> +}
> +
> +static void erofsmount_worker_exit(int err)
> +{
> +	_exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
> +}
> +
>   static void usage(int argc, char **argv)
>   {
>   	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
> @@ -720,6 +789,13 @@ static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
>   	}
>   	ctx.sk.fd = err;
>   
> +	err = erofsmount_worker_detach();
> +	if (err) {
> +		erofs_io_close(&ctx.vd);
> +		erofs_io_close(&ctx.sk);
> +		goto out_closefd;
> +	}
> +
>   	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
>   	if (err) {
>   		erofs_io_close(&ctx.vd);
> @@ -1050,67 +1126,79 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
>   static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
>   {
>   	int pipefd[2], err, num;
> +	pid_t ret;
>   
>   	err = pipe(pipefd);
>   	if (err < 0)
>   		return -errno;
>   
> -	if ((*pid = fork()) == 0) {
> +	ret = erofsmount_spawn_worker(pid);
> +	if (ret < 0) {
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		return ret;
> +	}
> +	if (ret == 0) {
>   		struct erofsmount_nbd_ctx ctx = {};
>   		char *recp;
>   
> -		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
> -		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
> -			exit(EXIT_FAILURE);
> -
>   		if (source->type == EROFSMOUNT_SOURCE_OCI) {
>   			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
>   				err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
>   							       source->ocicfg.tarindex_path,
>   							       source->ocicfg.zinfo_path);
>   				if (err)
> -					exit(EXIT_FAILURE);
> +					erofsmount_worker_exit(err);
>   			} else {
>   				err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
>   				if (err)
> -					exit(EXIT_FAILURE);
> +					erofsmount_worker_exit(err);
>   			}
>   		} else {
>   			err = open(source->device_path, O_RDONLY);
>   			if (err < 0)
> -				exit(EXIT_FAILURE);
> +				erofsmount_worker_exit(-errno);
>   			ctx.vd.fd = err;
>   		}
>   		recp = erofsmount_write_recovery_info(source);
>   		if (IS_ERR(recp)) {
>   			erofs_io_close(&ctx.vd);
> -			exit(EXIT_FAILURE);
> +			erofsmount_worker_exit(PTR_ERR(recp));
>   		}
>   
>   		num = -1;
>   		err = erofs_nbd_nl_connect(&num, 9, EROFSMOUNT_NBD_DISK_SIZE, recp);
> -		if (err >= 0) {
> -			ctx.sk.fd = err;
> -			err = erofsmount_nbd_fix_backend_linkage(num, &recp);
> -			if (err) {
> -				erofs_io_close(&ctx.sk);
> -			} else {
> -				err = write(pipefd[1], &num, sizeof(int));
> -				if (err < 0)
> -					err = -errno;
> -				close(pipefd[1]);
> -				close(pipefd[0]);
> -				if (err >= sizeof(int)) {
> -					err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
> -					goto out_fork;
> -				}
> -			}
> +		if (err < 0)
> +			goto err_vd;

Can we seperate refactering into another commit and
address this particular issue directly?

Also use `goto` for this particular case doesn't
seem much better for the code readability.

> +
> +		ctx.sk.fd = err;
> +		err = erofsmount_nbd_fix_backend_linkage(num, &recp);
> +		if (err)
> +			goto err_sk;
> +
> +		err = erofsmount_worker_detach();
> +		if (err)
> +			goto err_sk;
> +
> +		err = write(pipefd[1], &num, sizeof(int));
> +		if (err < 0)
> +			err = -errno;
> +		close(pipefd[1]);
> +		close(pipefd[0]);
> +		if (err >= (int)sizeof(int)) {
> +			err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
> +			goto out_fork;
>   		}
> +		goto err_sk;
> +
> +err_sk:
> +		erofs_io_close(&ctx.sk);
> +err_vd:
>   		erofs_io_close(&ctx.vd);
>   out_fork:
>   		(void)unlink(recp);
>   		free(recp);
> -		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
> +		erofsmount_worker_exit(err);
>   	}
>   	close(pipefd[1]);
>   	err = read(pipefd[0], &num, sizeof(int));
> @@ -1122,11 +1210,12 @@ out_fork:
>   
>   static int erofsmount_reattach(const char *target)
>   {
> -	char *identifier, *line, *source, *recp = NULL;
> +	char *identifier, *line = NULL, *source, *recp = NULL;
>   	struct erofsmount_nbd_ctx ctx = {};
> +	pid_t pid;
>   	int nbdnum, err;
>   	struct stat st;
> -	size_t n;
> +	size_t n = 0;
>   	FILE *f;
>   
>   	err = lstat(target, &st);
> @@ -1154,18 +1243,16 @@ static int erofsmount_reattach(const char *target)
>   	}
>   
>   	f = fopen(identifier ?: recp, "r");
> +	free(recp);
> +
>   	if (!f) {
>   		err = -errno;
> -		free(recp);
>   		goto err_identifier;
>   	}
> -	free(recp);
> -
> -	line = NULL;
>   	if ((err = getline(&line, &n, f)) <= 0) {
>   		err = -errno;
>   		fclose(f);
> -		goto err_identifier;
> +		goto err_line;
>   	}
>   	fclose(f);
>   	if (err && line[err - 1] == '\n')
> @@ -1202,18 +1289,27 @@ static int erofsmount_reattach(const char *target)
>   	}
>   
>   	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
> -	if (err >= 0) {

Same here.

Thanks,
Gao Xiang

> -		ctx.sk.fd = err;
> -		if (fork() == 0) {
> -			free(line);
> -			free(identifier);
> -			if ((uintptr_t)erofsmount_nbd_loopfn(&ctx))
> -				return EXIT_FAILURE;
> -			return EXIT_SUCCESS;
> -		}
> +	if (err < 0)
> +		goto err_vd;
> +	ctx.sk.fd = err;
> +
> +	err = erofsmount_spawn_worker(&pid);
> +	if (err < 0) {
>   		erofs_io_close(&ctx.sk);
> -		err = 0;
> +		goto err_vd;
> +	}
> +	if (err == 0) {
> +		free(line);
> +		free(identifier);
> +		err = erofsmount_worker_detach();
> +		if (!err)
> +			err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
> +		erofsmount_worker_exit(err);
>   	}
> +	erofs_io_close(&ctx.sk);
> +
> +	err = 0;
> +err_vd:
>   	erofs_io_close(&ctx.vd);
>   err_line:
>   	free(line);
> @@ -1251,9 +1347,15 @@ static int erofsmount_nbd(struct erofsmount_source *source,
>   		if (nbdfd < 0)
>   			return -errno;
>   
> -		if ((pid = fork()) == 0)
> -			return erofsmount_startnbd(nbdfd, source) ?
> -				EXIT_FAILURE : EXIT_SUCCESS;
> +		err = erofsmount_spawn_worker(&pid);
> +		if (err < 0) {
> +			close(nbdfd);
> +			return err;
> +		}
> +		if (err == 0) {
> +			err = erofsmount_startnbd(nbdfd, source);
> +			erofsmount_worker_exit(err);
> +		}
>   	} else {
>   		num = err;
>   		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
> @@ -1661,6 +1763,10 @@ static int erofsmount_fanotify_child(struct erofs_fanotify_ctx *ctx,
>   	if (err)
>   		goto notify;
>   
> +	err = erofsmount_worker_detach();
> +	if (err)
> +		goto notify;
> +
>   	err = 0;
>   notify:
>   	write(pipefd, &err, sizeof(err));
> @@ -1730,19 +1836,17 @@ static int erofsmount_fanotify(struct erofsmount_source *source,
>   		goto out;
>   	}
>   
> -	pid = fork();
> -	if (pid < 0) {
> -		err = -errno;
> +	err = erofsmount_spawn_worker(&pid);
> +	if (err < 0) {
>   		close(pipefd[0]);
>   		close(pipefd[1]);
>   		goto out;
>   	}
> -
> -	if (pid == 0) {
> +	if (err == 0) {
>   		close(pipefd[0]);
>   		err = erofsmount_fanotify_child(&ctx, pipefd[1]);
>   		erofsmount_fanotify_ctx_cleanup(&ctx);
> -		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
> +		erofsmount_worker_exit(err);
>   	}
>   
>   	/* Wait for child to report fanotify initialization result */


