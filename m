Return-Path: <linux-erofs+bounces-3447-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J5lGOT+C2qrTAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3447-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 08:10:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9523577C4B
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 08:10:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKPRh0hlyz2xqv;
	Tue, 19 May 2026 16:10:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.82
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779171040;
	cv=none; b=lQhjzPdO9oPEwTt5k9GfFm4Q5NUuCz3Y59YJbCIL+KJybOYgZV3TFNfHBRz1241dzRY74RaOUd3BeROd54hZoUjF/Hc1cQMW9TmMlJ3lN4Pe3Xb9lZw/uO3BfEKGkfauq3NKqeem5giCrji12tznXgdhWx0cpChhldBq3YCwYvuLeaSIEP1xQNCOYqtF6T6qBqjUvN7ij/SMC09Y+VwkNccs4CTCuhkrNt0mKl6Ho8EO7FnG/PssHcvXXan2WzDJIiU4zBrJK2RYcOcjHJW+N60zCA+l+RJYJnVNaMQ91umkiAs5NAg1NyQ+/1xtUhxwCOL7t3D8o4VYVO+90zjEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779171040; c=relaxed/relaxed;
	bh=Gmi918l7MH7SlGlcHnFUF3IhZe7UmQemOBK9zByL+nI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ayZ6P1yLVI0ulmaHY43bZlo4h8fHj/MkbaAbapsOphmstXE0FZFolhywmfcfhZoOEk6bgerRLGBDOKokU1BQ8tcjsSQLOLVituRMp5Fc9gDyqH/IMiuNkJhmcQ1S3yfxEROdby3jcIkrIlcRazOb8MKbmwpG6Q4xd3wdiJq2pm6BfK1SZv1MDVG9KAVXJTkPpqCU2OPshVrgbz/6pkGbySWTj7g0xHM0KZrREI0iBlNAV08qr1fAwYLozs70pxHt9XI/Ge0eZyrTVtMXL0PZwcQ6a0bflfNQ02dLrzBYP/bF7wrZwAJxDddfDSAAsbnMGcl2U/tGrVRJDIuGXRlk/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.82; helo=out28-82.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.82; helo=out28-82.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKPQJ13Flz2xSG
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 16:09:25 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00184158-0.00141576-0.996743;FP=9402193726124201655|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hak5nLF_1779170940;
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.hak5nLF_1779170940 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 14:09:01 +0800
From: hudsonZhu <hudson@cyzhu.com>
Message-Id: <2B6682EE-F54A-4107-8E4D-F337B20EB291@cyzhu.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_08E7206C-7CC7-461E-A4D2-B548E805D448"
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH rebased 3/3] erofs-utils: mount: integrate ublk backend
Date: Tue, 19 May 2026 14:08:50 +0800
In-Reply-To: <20260519043111.2007421-3-hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
 Chengyu Zhu <hudsonzhu@tencent.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20260315142745.56845-1-hudson@cyzhu.com>
 <20260519043111.2007421-1-hsiangkao@linux.alibaba.com>
 <20260519043111.2007421-3-hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[cyzhu.com];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3447-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tencent.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: A9523577C4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Apple-Mail=_08E7206C-7CC7-461E-A4D2-B548E805D448
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks, Gao Xiang.

Reviewed-by: hudsonzhu@tencent.com <mailto:hudsonzhu@tencent.com>

Thanks,
Chengyu

> 2026=E5=B9=B45=E6=9C=8819=E6=97=A5 12:31=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Chengyu Zhu <hudsonzhu@tencent.com>
>=20
> Wire up the ublk userspace block device backend into mount.erofs,
> providing an alternative to nbd for block device exposure.
>=20
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> mount/main.c | 266 ++++++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 244 insertions(+), 22 deletions(-)
>=20
> diff --git a/mount/main.c b/mount/main.c
> index 90fbdc68f88d..7713ba41058c 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -23,6 +23,7 @@
> #include "../lib/liberofs_fanotify.h"
> #endif
> #include "../lib/liberofs_s3.h"
> +#include "../lib/liberofs_ublk.h"
>=20
> #ifdef HAVE_LINUX_LOOP_H
> #include <linux/loop.h>
> @@ -51,6 +52,7 @@ struct loop_info {
>=20
> #define EROFSMOUNT_RUNDIR		"/var/run/erofs"
> #define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_RUNDIR =
"/mountnbd_nbd%d"
> +#define EROFSMOUNT_UBLK_REC_FMT	EROFSMOUNT_RUNDIR =
"/mountublk_ublkb%d"
>=20
> #ifdef EROFS_FANOTIFY_ENABLED
> #define EROFSMOUNT_FANOTIFY_HELP	", fanotify"
> @@ -58,12 +60,19 @@ struct loop_info {
> #define EROFSMOUNT_FANOTIFY_HELP	""
> #endif
>=20
> +#ifdef HAVE_LIBURING
> +#define EROFSMOUNT_UBLK_HELP		", ublk"
> +#else
> +#define EROFSMOUNT_UBLK_HELP		""
> +#endif
> +
> enum erofs_backend_drv {
> 	EROFSAUTO,
> 	EROFSLOCAL,
> 	EROFSFUSE,
> 	EROFSNBD,
> 	EROFSFANOTIFY,
> +	EROFSUBLK,
> };
>=20
> enum erofsmount_mode {
> @@ -117,10 +126,10 @@ static void usage(int argc, char **argv)
> 		" -d <0-9>                   set output verbosity; =
0=3Dquiet, 9=3Dverbose (default=3D%i)\n"
> 		" -o options                 comma-separated list of =
mount options\n"
> 		" -t type[.subtype]          filesystem type (and =
optional subtype)\n"
> -		"                            subtypes: fuse, local, nbd" =
EROFSMOUNT_FANOTIFY_HELP "\n"
> +		"                            subtypes: fuse, local, nbd" =
EROFSMOUNT_FANOTIFY_HELP EROFSMOUNT_UBLK_HELP "\n"
> 		" -u                         unmount the filesystem\n"
> 		"    --disconnect            abort an existing NBD =
device forcibly\n"
> -		"    --reattach              reattach to an existing NBD =
device\n"
> +		"    --reattach              reattach to an existing NBD =
or ublk device\n"
> #ifdef OCIEROFS_ENABLED
> 		"\n"
> 		"OCI-specific options (EXPERIMENTAL, with -o):\n"
> @@ -465,6 +474,12 @@ static int erofsmount_parse_options(int argc, =
char **argv)
> #else
> 					erofs_err("fanotify backend =
support is not built-in");
> 					return -EINVAL;
> +#endif
> +				} else if (!strcmp(dot + 1, "ublk")) {
> +#ifdef HAVE_LIBURING
> +					mountcfg.backend =3D EROFSUBLK;
> +#else
> +					erofs_err("ublk backend support =
is not built-in");
> #endif
> 				} else {
> 					erofs_err("invalid filesystem =
subtype `%s`", dot + 1);
> @@ -1399,11 +1414,29 @@ out_fork:
> 	return num;
> }
>=20
> +static int erofsmount_ublk_handler(void *ctx, struct =
erofs_ublk_request *req)
> +{
> +	struct erofs_vfile *vf =3D ctx;
> +	ssize_t ret;
> +
> +	if (req->op !=3D EROFS_UBLK_OP_READ)
> +		return -EOPNOTSUPP;
> +
> +	ret =3D erofs_io_pread(vf, req->buf, req->nr_sectors << 9,
> +			     req->start_sector << 9);
> +	if (ret < 0)
> +		return (int)ret;
> +
> +	req->result =3D ret;
> +	return 0;
> +}
> +
> static int erofsmount_reattach(const char *target)
> {
> 	struct erofsmount_nbd_ctx ctx =3D { .vd =3D &ctx._vd };
> +	int ublk_dev_id, nbdnum, err;
> +	char ublk_recp[64];
> 	char *identifier;
> -	int nbdnum, err;
> 	struct stat st;
> 	FILE *f;
>=20
> @@ -1411,7 +1444,48 @@ static int erofsmount_reattach(const char =
*target)
> 	if (err < 0)
> 		return -errno;
>=20
> -	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) !=3D =
EROFS_NBD_MAJOR)
> +	if (!S_ISBLK(st.st_mode))
> +		return -ENOTBLK;
> +
> +	if (sscanf(target, "/dev/ublkb%d", &ublk_dev_id) =3D=3D 1) {
> +		if (!erofs_ublk_is_recoverable(ublk_dev_id)) {
> +			erofs_err("ublk device %d is not recoverable",
> +				  ublk_dev_id);
> +			return -ENODEV;
> +		}
> +		snprintf(ublk_recp, sizeof(ublk_recp),
> +			 EROFSMOUNT_UBLK_REC_FMT, ublk_dev_id);
> +		f =3D fopen(ublk_recp, "r");
> +		if (!f) {
> +			erofs_err("cannot open recovery file %s: %s",
> +				  ublk_recp, strerror(errno));
> +			return -errno;
> +		}
> +		err =3D erofsmount_recovery_open_source(&ctx, f);
> +		if (err)
> +			return err;
> +		if (fork() =3D=3D 0) {
> +			if (erofs_ublk_init() < 0)
> +				exit(EXIT_FAILURE);
> +			err =3D erofs_ublk_recover_dev(ublk_dev_id,
> +						     =
erofsmount_ublk_handler,
> +						     &ctx.vd);
> +			if (err) {
> +				erofs_err("erofs_ublk_recover_dev: %s",
> +					  strerror(-err));
> +				exit(EXIT_FAILURE);
> +			}
> +			erofs_ublk_start(ublk_dev_id, -1);
> +			unlink(ublk_recp);
> +			erofs_ublk_destroy(ublk_dev_id);
> +			erofs_io_close(ctx.vd);
> +			exit(EXIT_SUCCESS);
> +		}
> +		erofs_io_close(ctx.vd);
> +		return 0;
> +	}
> +
> +	if (major(st.st_rdev) !=3D EROFS_NBD_MAJOR)
> 		return -ENOTBLK;
>=20
> 	nbdnum =3D erofs_nbd_get_index_from_minor(minor(st.st_rdev));
> @@ -2034,6 +2108,130 @@ out:
> }
> #endif
>=20
> +static int erofsmount_ublk(struct erofsmount_source *source,
> +			   const char *mountpoint, const char *fstype,
> +			   int flags, const char *options)
> +{
> +	int pipefd[2];
> +	char dev_path[64];
> +	pid_t pid;
> +	int dev_id, err;
> +	char ready;
> +
> +	err =3D erofs_ublk_init();
> +	if (err) {
> +		erofs_err("ublk not supported");
> +		return err;
> +	}
> +
> +	if (pipe(pipefd) < 0)
> +		return -errno;
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		return -errno;
> +	}
> +
> +	if (pid =3D=3D 0) {
> +		struct erofsmount_nbd_ctx ctx =3D { .vd =3D &ctx._vd };
> +		struct erofs_ublk_dev_info info =3D {};
> +		char ublk_recp[64], *recp;
> +		struct stat st;
> +
> +		close(pipefd[0]);
> +
> +		err =3D erofsmount_open_source(&ctx, source);
> +		if (err)
> +			exit(EXIT_FAILURE);
> +
> +		info.nr_hw_queues =3D 1;
> +		info.queue_depth =3D 64;
> +		info.max_io_buf_bytes =3D 65536;
> +		info.dev_id =3D -1;
> +		info.blkbits =3D 12;
> +		info.flags =3D EROFS_UBLK_F_USER_RECOVERY;
> +
> +		if (source->type =3D=3D EROFSMOUNT_SOURCE_LOCAL &&
> +		    erofs_io_fstat(ctx.vd, &st) =3D=3D 0)
> +			info.dev_size =3D st.st_size;
> +		else
> +			info.dev_size =3D INT64_MAX;
> +
> +		dev_id =3D erofs_ublk_create_dev(&info,
> +				erofsmount_ublk_handler, ctx.vd);
> +		if (dev_id < 0) {
> +			erofs_err("erofs_ublk_create_dev failed: %s",
> +				  strerror(-dev_id));
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		snprintf(ublk_recp, sizeof(ublk_recp),
> +			 EROFSMOUNT_UBLK_REC_FMT, dev_id);
> +		recp =3D erofsmount_write_recovery_info(source);
> +		if (IS_ERR(recp)) {
> +			erofs_err("write_recovery_info: %s",
> +				  strerror(-(int)PTR_ERR(recp)));
> +		} else {
> +			if (rename(recp, ublk_recp))
> +				erofs_err("rename recovery: %s",
> +					  strerror(errno));
> +			free(recp);
> +		}
> +
> +		if (write(pipefd[1], &dev_id,
> +			  sizeof(dev_id)) !=3D sizeof(dev_id))
> +			exit(EXIT_FAILURE);
> +
> +		err =3D erofs_ublk_start(dev_id, pipefd[1]);
> +		if (err)
> +			erofs_err("erofs_ublk_start: %s",
> +				  strerror(-err));
> +
> +		unlink(ublk_recp);
> +		erofs_ublk_destroy(dev_id);
> +		erofs_io_close(ctx.vd);
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	close(pipefd[1]);
> +	if (read(pipefd[0], &dev_id, sizeof(dev_id)) !=3D
> +	    sizeof(dev_id)) {
> +		waitpid(pid, NULL, 0);
> +		close(pipefd[0]);
> +		return -EIO;
> +	}
> +
> +	snprintf(dev_path, sizeof(dev_path),
> +		 "/dev/ublkb%d", dev_id);
> +
> +	if (read(pipefd[0], &ready, 1) !=3D 1) {
> +		waitpid(pid, NULL, 0);
> +		close(pipefd[0]);
> +		return -EIO;
> +	}
> +	close(pipefd[0]);
> +
> +	err =3D mount(dev_path, mountpoint, fstype, flags, options);
> +	if (err < 0) {
> +		err =3D -errno;
> +		kill(pid, SIGTERM);
> +		waitpid(pid, NULL, 0);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static int ublk_dev_id_from_path(const char *path)
> +{
> +	int dev_id;
> +
> +	if (sscanf(path, "/dev/ublkb%d", &dev_id) =3D=3D 1)
> +		return dev_id;
> +	return -1;
> +}
> +
> int erofsmount_umount(char *target)
> {
> 	char *device =3D NULL, *mountpoint =3D NULL;
> @@ -2071,7 +2269,7 @@ int erofsmount_umount(char *target)
>=20
> 	for (s =3D NULL; (getline(&s, &n, mounts)) > 0;) {
> 		bool hit =3D false;
> -		char *f1, *f2, *end;
> +		char *f1, *f2 =3D NULL, *end;
>=20
> 		f1 =3D s;
> 		end =3D strchr(f1, ' ');
> @@ -2088,31 +2286,48 @@ int erofsmount_umount(char *target)
> 				hit =3D true;
> 		}
> 		if (hit) {
> -			if (isblk) {
> -				err =3D -EBUSY;
> -				free(s);
> -				fclose(mounts);
> -				goto err_out;
> -			}
> 			free(device);
> 			device =3D strdup(f1);
> -			if (!mountpoint)
> -				mountpoint =3D strdup(f2);
> +			free(mountpoint);
> +			mountpoint =3D f2 ? strdup(f2) : NULL;
> 		}
> 	}
> 	free(s);
> 	fclose(mounts);
> +
> +	if (isblk && !device) {
> +		if (S_ISBLK(st.st_mode) && major(st.st_rdev) =3D=3D =
EROFS_NBD_MAJOR) {
> +			nbdnum =3D =
erofs_nbd_get_index_from_minor(minor(st.st_rdev));
> +			err =3D erofs_nbd_nl_disconnect(nbdnum);
> +			if (err !=3D -EOPNOTSUPP)
> +				goto err_out;
> +		}
> +		err =3D ublk_dev_id_from_path(target);
> +		if (err >=3D 0) {
> +			err =3D erofs_ublk_del_dev_by_id(err);
> +			goto err_out;
> +		}
> +		err =3D -ENOENT;
> +		goto err_out;
> +	}
> +
> 	if (!isblk && !device) {
> 		err =3D -ENOENT;
> 		goto err_out;
> 	}
>=20
> -	if (isblk && !mountpoint &&
> -	    S_ISBLK(st.st_mode) && major(st.st_rdev) =3D=3D =
EROFS_NBD_MAJOR) {
> -		nbdnum =3D =
erofs_nbd_get_index_from_minor(minor(st.st_rdev));
> -		err =3D erofs_nbd_nl_disconnect(nbdnum);
> -		if (err !=3D -EOPNOTSUPP)
> -			return err;
> +	err =3D ublk_dev_id_from_path(device);
> +	if (err >=3D 0) {
> +		if (mountpoint) {
> +			int ret =3D umount(mountpoint);
> +
> +			if (ret) {
> +				err =3D -errno;
> +				goto err_out;
> +			}
> +		}
> +		err =3D erofs_ublk_del_dev_by_id(err);
> +		goto err_out;
> 	}
>=20
> 	/* Avoid TOCTOU issue with NBD_CFLAG_DISCONNECT_ON_CLOSE */
> @@ -2224,13 +2439,20 @@ int main(int argc, char *argv[])
> 		goto exit;
> 	}
>=20
> -	if (mountcfg.backend =3D=3D EROFSNBD) {
> +	if (mountcfg.backend =3D=3D EROFSNBD || mountcfg.backend =3D=3D =
EROFSUBLK) {
> 		if (mountsrc.type =3D=3D EROFSMOUNT_SOURCE_OCI)
> 			mountsrc.ocicfg.image_ref =3D mountcfg.device;
> 		else
> 			mountsrc.device_path =3D mountcfg.device;
> -		err =3D erofsmount_nbd(&mountsrc, mountcfg.target,
> -				     mountcfg.fstype, mountcfg.flags, =
mountcfg.options);
> +
> +		if (mountcfg.backend =3D=3D EROFSNBD)
> +			err =3D erofsmount_nbd(&mountsrc, =
mountcfg.target,
> +					     mountcfg.fstype, =
mountcfg.flags,
> +					     mountcfg.options);
> +		else
> +			err =3D erofsmount_ublk(&mountsrc, =
mountcfg.target,
> +					      mountcfg.fstype, =
mountcfg.flags,
> +					      mountcfg.options);
> 		goto exit;
> 	}
>=20
> --=20
> 2.43.5
>=20


--Apple-Mail=_08E7206C-7CC7-461E-A4D2-B548E805D448
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Thanks, Gao =
Xiang.<div><br></div><div>Reviewed-by: <a =
href=3D"mailto:hudsonzhu@tencent.com">hudsonzhu@tencent.com</a></div><div>=
<br></div><div>Thanks,</div><div>Chengyu<br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>2026=E5=B9=B45=E6=9C=8819=E6=97=A5 12:31=EF=BC=8CGao =
Xiang &lt;hsiangkao@linux.alibaba.com&gt; =E5=86=99=E9=81=93=EF=BC=9A</div=
><br class=3D"Apple-interchange-newline"><div><div>From: Chengyu Zhu =
&lt;hudsonzhu@tencent.com&gt;<br><br>Wire up the ublk userspace block =
device backend into mount.erofs,<br>providing an alternative to nbd for =
block device exposure.<br><br>Signed-off-by: Chengyu Zhu =
&lt;hudsonzhu@tencent.com&gt;<br>Signed-off-by: Gao Xiang =
&lt;hsiangkao@linux.alibaba.com&gt;<br>---<br> mount/main.c | 266 =
++++++++++++++++++++++++++++++++++++++++++++++-----<br> 1 file changed, =
244 insertions(+), 22 deletions(-)<br><br>diff --git a/mount/main.c =
b/mount/main.c<br>index 90fbdc68f88d..7713ba41058c 100644<br>--- =
a/mount/main.c<br>+++ b/mount/main.c<br>@@ -23,6 +23,7 @@<br> #include =
"../lib/liberofs_fanotify.h"<br> #endif<br> #include =
"../lib/liberofs_s3.h"<br>+#include "../lib/liberofs_ublk.h"<br><br> =
#ifdef HAVE_LINUX_LOOP_H<br> #include &lt;linux/loop.h&gt;<br>@@ -51,6 =
+52,7 @@ struct loop_info {<br><br> #define EROFSMOUNT_RUNDIR<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"/var/run/erofs"<br> #define EROFSMOUNT_NBD_REC_FMT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>EROFSMOUNT_RUNDIR "/mountnbd_nbd%d"<br>+#define =
EROFSMOUNT_UBLK_REC_FMT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>EROFSMOUNT_RUNDIR =
"/mountublk_ublkb%d"<br><br> #ifdef EROFS_FANOTIFY_ENABLED<br> #define =
EROFSMOUNT_FANOTIFY_HELP<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>", fanotify"<br>@@ -58,12 +60,19 =
@@ struct loop_info {<br> #define EROFSMOUNT_FANOTIFY_HELP<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>""<br> =
#endif<br><br>+#ifdef HAVE_LIBURING<br>+#define =
EROFSMOUNT_UBLK_HELP<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>", ublk"<br>+#else<br>+#define =
EROFSMOUNT_UBLK_HELP<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>""<br>+#endif<br>+<br> enum =
erofs_backend_drv {<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>EROFSAUTO,<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>EROFSLOCAL,<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>EROFSFUSE,<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>EROFSNBD,<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>EROFSFANOTIFY,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>EROFSUBLK,<br> };<br><br> enum erofsmount_mode {<br>@@ -117,10 =
+126,10 @@ static void usage(int argc, char **argv)<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>" -d =
&lt;0-9&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set output verbosity; 0=3Dquiet, =
9=3Dverbose (default=3D%i)\n"<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>" -o options =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;comma-separated list of mount options\n"<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>" -t =
type[.subtype] =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;filesystem type =
(and optional subtype)\n"<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>" =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP =
"\n"<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>" =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP =
EROFSMOUNT_UBLK_HELP "\n"<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>" -u =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unmo=
unt the filesystem\n"<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>" &nbsp;&nbsp;&nbsp;--disconnect =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;abort =
an existing NBD device forcibly\n"<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>" &nbsp;&nbsp;&nbsp;--reattach =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;reattach to an existing NBD device\n"<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>" =
&nbsp;&nbsp;&nbsp;--reattach =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;reattach to an existing NBD or ublk device\n"<br> #ifdef =
OCIEROFS_ENABLED<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>"\n"<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"OCI-specific options (EXPERIMENTAL, with -o):\n"<br>@@ -465,6 =
+474,12 @@ static int erofsmount_parse_options(int argc, char =
**argv)<br> #else<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("fanotify backend =
support is not built-in");<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return =
-EINVAL;<br>+#endif<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>} else if (!strcmp(dot + 1, =
"ublk")) {<br>+#ifdef HAVE_LIBURING<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>mountcfg.backend =3D =
EROFSUBLK;<br>+#else<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("ublk backend support =
is not built-in");<br> #endif<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>} else {<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_err("invalid filesystem subtype `%s`", dot + 1);<br>@@ =
-1399,11 +1414,29 @@ out_fork:<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return num;<br> }<br><br>+static =
int erofsmount_ublk_handler(void *ctx, struct erofs_ublk_request =
*req)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>struct erofs_vfile *vf =3D ctx;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>ssize_t ret;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(req-&gt;op !=3D EROFS_UBLK_OP_READ)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return =
-EOPNOTSUPP;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>ret =3D erofs_io_pread(vf, =
req-&gt;buf, req-&gt;nr_sectors &lt;&lt; 9,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;req-&gt;start_sector &lt;&lt; 9);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (ret =
&lt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return (int)ret;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>req-&gt;result =3D ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
0;<br>+}<br>+<br> static int erofsmount_reattach(const char *target)<br> =
{<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>struct erofsmount_nbd_ctx ctx =3D { .vd =3D &amp;ctx._vd =
};<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>int ublk_dev_id, nbdnum, err;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>char ublk_recp[64];<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>char =
*identifier;<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>int nbdnum, err;<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct stat st;<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>FILE =
*f;<br><br>@@ -1411,7 +1444,48 @@ static int erofsmount_reattach(const =
char *target)<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err &lt; 0)<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
-errno;<br><br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (!S_ISBLK(st.st_mode) || major(st.st_rdev) !=3D =
EROFS_NBD_MAJOR)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if =
(!S_ISBLK(st.st_mode))<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return -ENOTBLK;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(sscanf(target, "/dev/ublkb%d", &amp;ublk_dev_id) =3D=3D 1) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(!erofs_ublk_is_recoverable(ublk_dev_id)) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_err("ublk device %d is not recoverable",<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;ublk_dev_id);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return -ENODEV;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>snprintf(ublk_recp, sizeof(ublk_recp),<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
EROFSMOUNT_UBLK_REC_FMT, ublk_dev_id);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>f =3D fopen(ublk_recp, =
"r");<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (!f) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("cannot open recovery =
file %s: %s",<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> &nbsp;ublk_recp, =
strerror(errno));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return -errno;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>err =3D erofsmount_recovery_open_source(&amp;ctx, f);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(err)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return err;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (fork() =3D=3D 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(erofs_ublk_init() &lt; 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>exit(EXIT_FAILURE);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
erofs_ublk_recover_dev(ublk_dev_id,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;erofsmount_ublk_handler,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;&amp;ctx.vd);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_err("erofs_ublk_recover_dev: %s",<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;strerror(-err));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>exit(EXIT_FAILURE);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_ublk_start(ublk_dev_id, -1);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>unlink(ublk_recp);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>erofs_ublk_destroy(ublk_dev_id);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_io_close(ctx.vd);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>exit(EXIT_SUCCESS);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_io_close(ctx.vd);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (major(st.st_rdev) !=3D =
EROFS_NBD_MAJOR)<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return -ENOTBLK;<br><br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>nbdnum =3D =
erofs_nbd_get_index_from_minor(minor(st.st_rdev));<br>@@ -2034,6 =
+2108,130 @@ out:<br> }<br> #endif<br><br>+static int =
erofsmount_ublk(struct erofsmount_source *source,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;const char *mountpoint, const char *fstype,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;int flags, const char *options)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int =
pipefd[2];<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>char dev_path[64];<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>pid_t pid;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int =
dev_id, err;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>char ready;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>err =3D =
erofs_ublk_init();<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_err("ublk not supported");<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return err;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (pipe(pipefd) &lt; =
0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return -errno;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>pid =3D fork();<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (pid =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>close(pipefd[0]);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>close(pipefd[1]);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
-errno;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (pid =3D=3D 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct =
erofsmount_nbd_ctx ctx =3D { .vd =3D &amp;ctx._vd };<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct =
erofs_ublk_dev_info info =3D {};<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>char ublk_recp[64], =
*recp;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>struct stat st;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>close(pipefd[0]);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
erofsmount_open_source(&amp;ctx, source);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(err)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>exit(EXIT_FAILURE);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>info.nr_hw_queues =3D =
1;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>info.queue_depth =3D 64;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>info.max_io_buf_bytes =3D =
65536;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>info.dev_id =3D -1;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>info.blkbits =3D 12;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>info.flags =3D EROFS_UBLK_F_USER_RECOVERY;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(source-&gt;type =3D=3D EROFSMOUNT_SOURCE_LOCAL &amp;&amp;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;erofs_io_fstat(ctx.vd, &amp;st) =3D=3D 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>info.dev_size =3D st.st_size;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>info.dev_size =3D INT64_MAX;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>dev_id =3D =
erofs_ublk_create_dev(&amp;info,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofsmount_ublk_handler, =
ctx.vd);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (dev_id &lt; 0) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("erofs_ublk_create_dev =
failed: %s",<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;strerror(-dev_id));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>exit(EXIT_FAILURE);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>snprintf(ublk_recp, =
sizeof(ublk_recp),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> EROFSMOUNT_UBLK_REC_FMT, =
dev_id);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>recp =3D erofsmount_write_recovery_info(source);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(IS_ERR(recp)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("write_recovery_info: =
%s",<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;strerror(-(int)PTR_ERR(recp)));<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>} else =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (rename(recp, ublk_recp))<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("rename recovery: =
%s",<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;strerror(errno));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>free(recp);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (write(pipefd[1], =
&amp;dev_id,<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;sizeof(dev_id)) !=3D sizeof(dev_id))<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>exit(EXIT_FAILURE);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>err =3D erofs_ublk_start(dev_id, =
pipefd[1]);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (err)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_err("erofs_ublk_start: =
%s",<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;strerror(-err));<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>unlink(ublk_recp);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_ublk_destroy(dev_id);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>erofs_io_close(ctx.vd);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>exit(EXIT_SUCCESS);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>close(pipefd[1]);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (read(pipefd[0], &amp;dev_id, =
sizeof(dev_id)) !=3D<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;sizeof(dev_id)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>waitpid(pid, NULL, 0);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>close(pipefd[0]);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return -EIO;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>snprintf(dev_path, =
sizeof(dev_path),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> "/dev/ublkb%d", =
dev_id);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (read(pipefd[0], &amp;ready, =
1) !=3D 1) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>waitpid(pid, NULL, 0);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>close(pipefd[0]);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
-EIO;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>close(pipefd[0]);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>err =3D mount(dev_path, =
mountpoint, fstype, flags, options);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
-errno;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>kill(pid, SIGTERM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>waitpid(pid, NULL, 0);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
err;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return 0;<br>+}<br>+<br>+static int ublk_dev_id_from_path(const =
char *path)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>int dev_id;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(sscanf(path, "/dev/ublkb%d", &amp;dev_id) =3D=3D 1)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
dev_id;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return -1;<br>+}<br>+<br> int erofsmount_umount(char *target)<br> =
{<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>char *device =3D NULL, *mountpoint =3D NULL;<br>@@ -2071,7 =
+2269,7 @@ int erofsmount_umount(char *target)<br><br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>for (s =3D =
NULL; (getline(&amp;s, &amp;n, mounts)) &gt; 0;) {<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>bool hit =
=3D false;<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>char *f1, *f2, *end;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>char *f1, *f2 =3D NULL, =
*end;<br><br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>f1 =3D s;<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>end =3D strchr(f1, ' ');<br>@@ =
-2088,31 +2286,48 @@ int erofsmount_umount(char *target)<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>hit =3D =
true;<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (hit) {<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (isblk) {<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
-EBUSY;<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>free(s);<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>fclose(mounts);<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>goto =
err_out;<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>free(device);<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>device =3D strdup(f1);<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(!mountpoint)<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>mountpoint =3D =
strdup(f2);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>free(mountpoint);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>mountpoint =3D f2 ? strdup(f2) : =
NULL;<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>free(s);<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>fclose(mounts);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (isblk =
&amp;&amp; !device) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (S_ISBLK(st.st_mode) =
&amp;&amp; major(st.st_rdev) =3D=3D EROFS_NBD_MAJOR) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>nbdnum =3D =
erofs_nbd_get_index_from_minor(minor(st.st_rdev));<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
erofs_nbd_nl_disconnect(nbdnum);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err !=3D =
-EOPNOTSUPP)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>goto err_out;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
ublk_dev_id_from_path(target);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err &gt;=3D 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
erofs_ublk_del_dev_by_id(err);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>goto err_out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>err =3D -ENOENT;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>goto err_out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (!isblk &amp;&amp; !device) =
{<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>err =3D -ENOENT;<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>goto err_out;<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br><br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>if (isblk &amp;&amp; !mountpoint &amp;&amp;<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;S_ISBLK(st.st_mode) &amp;&amp; major(st.st_rdev) =3D=3D =
EROFS_NBD_MAJOR) {<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>nbdnum =3D =
erofs_nbd_get_index_from_minor(minor(st.st_rdev));<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
erofs_nbd_nl_disconnect(nbdnum);<br>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err !=3D =
-EOPNOTSUPP)<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return err;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>err =3D =
ublk_dev_id_from_path(device);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (err &gt;=3D 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(mountpoint) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>int ret =3D =
umount(mountpoint);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (ret) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
-errno;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>goto err_out;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>err =3D erofs_ublk_del_dev_by_id(err);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>goto =
err_out;<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br><br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>/* Avoid TOCTOU issue with NBD_CFLAG_DISCONNECT_ON_CLOSE =
*/<br>@@ -2224,13 +2439,20 @@ int main(int argc, char *argv[])<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>goto =
exit;<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br><br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>if (mountcfg.backend =3D=3D EROFSNBD) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(mountcfg.backend =3D=3D EROFSNBD || mountcfg.backend =3D=3D EROFSUBLK) =
{<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (mountsrc.type =3D=3D EROFSMOUNT_SOURCE_OCI)<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>mountsrc.ocicfg.image_ref =3D mountcfg.device;<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>else<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>mountsrc.device_path =3D mountcfg.device;<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D =
erofsmount_nbd(&amp;mountsrc, mountcfg.target,<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;mountcfg.fstype, mountcfg.flags, =
mountcfg.options);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (mountcfg.backend =3D=3D =
EROFSNBD)<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>err =3D erofsmount_nbd(&amp;mountsrc, mountcfg.target,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;mountcfg.fstype, mountcfg.flags,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;mountcfg.options);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>else<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>err =3D erofsmount_ublk(&amp;mountsrc, mountcfg.target,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mountcfg.fstype, mountcfg.flags,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mountcfg.options);<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>goto =
exit;<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>}<br><br>-- =
<br>2.43.5<br><br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_08E7206C-7CC7-461E-A4D2-B548E805D448--

