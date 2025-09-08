Return-Path: <linux-erofs+bounces-983-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5086B48A8B
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Sep 2025 12:52:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cL3h6311jz2xgX;
	Mon,  8 Sep 2025 20:52:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757328774;
	cv=none; b=PUT+1T5IjUVRev1kvjc4f35DtRolOXQzZtYvQyvVEG8LAjgpiuJLM4huBuoFlbx9/bOSaZHeg/x4Up4XvCaPZQyRMqv36ejAe6Xy3MY9+JUfe+RRDp2XKfQNFCg1fh4zcwFJ0xXvmwsBvPQYRvKzMdzkAWszdnHZtRWZOTuX01E8rDVDwR/Mq6qK7walYPSpdcZWFUXPAGQmKmRZyh1arePGvS/xK4BeFxN+XIxm1HFDbGrxVHUno1cnL42Edkb8mCR+9i1p6dVQu8oZyzNi/RcYQ4RuUYRJJkO805+IWjs2AVFLuFHL1mamRqZx7+bvqkNmmjPGWJ3zRrxpXWLUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757328774; c=relaxed/relaxed;
	bh=rlFdRCmEfaiHEH2YYHIiVRBtSOcKO50YmrMUDDMKOcE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VQUirPBnaxLslwKGlyxRygwBvWXnji7pCe9i4+87eiu5lQbPEOguUsnPulsxL2bz8Ih0v5k27etqAA84w1lzyIBHlaSwhqrn0hFj8UGVOrnBMnZby0syzsp94ltAkD5k87yWcowfUg246e8+iD9nGJp4NmEqaM3/1AycAmjfYLdzSK9m46YCu4fOC34Dq8WMQ89GbVwTOO9hVwBvHL/HbJ68B6/eNP75WWiuM0+rWq5Y8+qj5kNBqRITEExnMhsEaQgqKcN7zXKymXn+YnwTrudnLf+yI16CpT+a9Ld3vhANxPhUA0jy/q2p43LxmPooJnlKlrkQWPaQy7mRqocxBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.43; helo=out28-43.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.43; helo=out28-43.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-43.mail.aliyun.com (out28-43.mail.aliyun.com [115.124.28.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cL3h42QgYz2xQ6
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Sep 2025 20:52:49 +1000 (AEST)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eaMbggF_1757328763 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 18:52:44 +0800
Content-Type: text/plain;
	charset=utf-8
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
Subject: Re: [PATCH v2] erofs-utils: add NBD-backed OCI image mounting
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <799913f4-39a6-48f8-9aaf-a43b425fab71@linux.alibaba.com>
Date: Mon, 8 Sep 2025 18:52:33 +0800
Cc: linux-erofs@lists.ozlabs.org,
 xiang@kernel.org,
 Chengyu Zhu <hudsonzhu@tencent.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BF4FCC2-2A65-41A9-83C8-B268D111757A@cyzhu.com>
References: <20250904100719.31892-1-hudson@cyzhu.com>
 <20250905143021.91960-1-hudson@cyzhu.com>
 <799913f4-39a6-48f8-9aaf-a43b425fab71@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

>> +	if (offset >=3D blob_size)
>=20
> It's possible that NBD reads offset >=3D blob_size here, so I think =
you
> should
>=20
> 	if (offset >=3D blob_size) {
> 		*out_size =3D 0;
> 		return 0;
> 	}
>=20
> Here.
Done.

>> +		return 0;
>> +
>> +	if (length && offset + (off_t)length > blob_size)
>=20
>=20
> 		why `(off_t)length`? since length is already `off_t`.
>=20
>=20
>> +		length =3D (size_t)(blob_size - offset);
>=20
>=20
> 	if (offset + length > blob_size)
> 		length =3D blob_size - offset.
>=20
> ?
Done.


>> +		if (!offset) {
>> +			*out_buf =3D resp.data;
>> +			*out_size =3D resp.size;
>> +			resp.data =3D NULL;
>> +			ret =3D 0;
>> +		} else {
>=20
> 		} else if (offset < resp.size) {
> 			available =3D resp.size - offset;
> 			...
> 		}
Done.

>>    			err =3D IS_ERR(id) ? PTR_ERR(id) :
>> @@ -789,9 +887,19 @@ int main(int argc, char *argv[])
>>  	}
>>    	if (mountcfg.backend =3D=3D EROFSNBD) {
>> -		err =3D erofsmount_nbd(mountcfg.device, mountcfg.target,
>> -				     mountcfg.fstype, mountcfg.flags,
>> -				     mountcfg.options);
>> +		if (mountcfg.use_oci) {
>> +			struct erofs_vfile vfile =3D {};
>=20
> Could you just move this to
> 	ocierofs_io_open() instead?
>=20
> e.g.
> 	vfile =3D (struct erofs_vfile){.ops =3D &ocierofs_io_vfops};
> 	*(struct ocierofs_iostream **)vfile->payload =3D oci_iostream;
Done.

>> +
>> +			ocicfg.image_ref =3D mountcfg.device;
>> +			src.vf =3D &vfile;
>> +			err =3D erofsmount_nbd(src, EROFSNBD_SOURCE_OCI, =
mountcfg.target,
>> +					     mountcfg.fstype, =
mountcfg.flags, mountcfg.options);
>> +		} else {
>> +			src.device_path =3D mountcfg.device;
>> +			err =3D erofsmount_nbd(src, =
EROFSNBD_SOURCE_LOCAL, mountcfg.target,
>> +					     mountcfg.fstype, =
mountcfg.flags,
>> +					     mountcfg.options);
>> +		}
>=20
> I think you could just
>=20
> 		struct erofs_vfile vfile;
> 		int sourcetype;
>=20
> 		if (mountcfg.use_oci) {
> 			sourcetype =3D EROFSNBD_SOURCE_OCI;
> 			ocicfg.image_ref =3D mountcfg.device;
> 			src.vf =3D &vfile;
> 		} else {
> 			sourcetype =3D EROFSNBD_SOURCE_LOCAL;
> 			src.device_path =3D mountcfg.device;
> 		}
>=20
> 		err =3D erofsmount_nbd(src, sourcetype, mountcfg.target,
> 				     mountcfg.fstype, mountcfg.flags,
> 				     mountcfg.options);
>=20
Done.

Thanks,
Chengyu


> 2025=E5=B9=B49=E6=9C=888=E6=97=A5 16:35=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Chengyu,
>=20
> On 2025/9/5 22:30, ChengyuZhu6 wrote:
>> From: Chengyu Zhu <hudsonzhu@tencent.com>
>> - Add HTTP range downloads for OCI blobs
>> - Introduce ocierofs_iostream for virtual file I/O
>> - Add oci option for OCI image mounting with NBD backend
>> New mount.erofs -t erofs.nbd option: -o=3D[options] source-image =
mountpoint
>> Supported oci options:
>> - oci.platform=3Dos/arch (default: linux/amd64)
>> - oci=3DN (extract specific layer, default: all layers)
>> - oci.username/oci.password (basic authentication)
>> e.g.:
>> sudo mount.erofs -t erofs.nbd  -o 'oci=3D0,oci.platform=3Dlinux/amd64' =
\
>> quay.io/chengyuzhu6/golang:1.22.8-erofs /mnt
>> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
>=20
> Sorry for late reply.
>=20
>> ---
>>  lib/liberofs_oci.h |   8 +-
>>  lib/remotes/oci.c  | 247 =
++++++++++++++++++++++++++++++++++++++++++++-
>>  mount/Makefile.am  |   2 +-
>>  mount/main.c       | 196 +++++++++++++++++++++++++++--------
>>  4 files changed, 406 insertions(+), 47 deletions(-)
>> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
>> index 2896308..873a560 100644
>> --- a/lib/liberofs_oci.h
>> +++ b/lib/liberofs_oci.h
>> @@ -55,7 +55,11 @@ struct ocierofs_ctx {
>>  	int layer_count;
>>  };
>>  -int ocierofs_init(struct ocierofs_ctx *ctx, const struct =
ocierofs_config *config);
>> +struct ocierofs_iostream {
>> +	struct ocierofs_ctx *ctx;
>> +	struct erofs_vfile vf;
>=20
> Why need this?
>=20
>> +	u64 offset;
>> +};
>>    /*
>>   * ocierofs_build_trees - Build file trees from OCI container image =
layers
>> @@ -67,6 +71,8 @@ int ocierofs_init(struct ocierofs_ctx *ctx, const =
struct ocierofs_config *config
>>  int ocierofs_build_trees(struct erofs_importer *importer,
>>  			 const struct ocierofs_config *cfg);
>>  +int ocierofs_io_open(struct erofs_vfile *vf, const struct =
ocierofs_config *cfg);
>> +
>>  #ifdef __cplusplus
>>  }
>>  #endif
>> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
>> index f2b08b2..ba01a0e 100644
>> --- a/lib/remotes/oci.c
>> +++ b/lib/remotes/oci.c
>> @@ -16,6 +16,7 @@
>>  #include <json-c/json.h>
>>  #include "erofs/importer.h"
>>  #include "erofs/internal.h"
>> +#include "erofs/io.h"
>>  #include "erofs/print.h"
>>  #include "erofs/tar.h"
>>  #include "liberofs_oci.h"
>> @@ -33,6 +34,8 @@
>>  #define OCI_MEDIATYPE_MANIFEST =
"application/vnd.oci.image.manifest.v1+json"
>>  #define OCI_MEDIATYPE_INDEX =
"application/vnd.oci.image.index.v1+json"
>>  +#define OCIEROFS_IO_CHUNK_SIZE 32768
>> +
>>  struct ocierofs_request {
>>  	char *url;
>>  	struct curl_slist *headers;
>> @@ -1032,7 +1035,7 @@ static int ocierofs_parse_ref(struct =
ocierofs_ctx *ctx, const char *ref_str)
>>   *
>>   * Return: 0 on success, negative errno on failure
>>   */
>> -int ocierofs_init(struct ocierofs_ctx *ctx, const struct =
ocierofs_config *config)
>> +static int ocierofs_init(struct ocierofs_ctx *ctx, const struct =
ocierofs_config *config)
>>  {
>>  	int ret;
>>  @@ -1226,3 +1229,245 @@ int ocierofs_build_trees(struct =
erofs_importer *importer,
>>  	ocierofs_ctx_cleanup(&ctx);
>>  	return ret;
>>  }
>> +
>> +static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, =
off_t offset, size_t length,
>> +					void **out_buf, size_t =
*out_size)
>> +{
>> +	struct ocierofs_request req =3D {};
>> +	struct ocierofs_response resp =3D {};
>> +	const char *api_registry;
>> +	char rangehdr[64];
>> +	long http_code =3D 0;
>> +	int ret;
>> +	int index =3D ctx->layer_index;
>> +	u64 blob_size =3D ctx->layers[index]->size;
>> +	size_t available;
>> +	size_t copy_size;
>> +
>> +	if (offset < 0)
>> +		return -EINVAL;
>> +
>> +	if (offset >=3D blob_size)
>=20
> It's possible that NBD reads offset >=3D blob_size here, so I think =
you
> should
>=20
> 	if (offset >=3D blob_size) {
> 		*out_size =3D 0;
> 		return 0;
> 	}
>=20
> here.
>=20
>> +		return 0;
>> +
>> +	if (length && offset + (off_t)length > blob_size)
>=20
>=20
> 		why `(off_t)length`? since length is already `off_t`.
>=20
>=20
>> +		length =3D (size_t)(blob_size - offset);
>=20
>=20
> 	if (offset + length > blob_size)
> 		length =3D blob_size - offset.
>=20
> ?
>=20
>> +
>> +	api_registry =3D ocierofs_get_api_registry(ctx->registry);
>> +	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
>> +	     api_registry, ctx->repository, ctx->layers[index]->digest) =
=3D=3D -1)
>> +		return -ENOMEM;
>> +
>> +	if (length)
>> +		snprintf(rangehdr, sizeof(rangehdr), "Range: =
bytes=3D%lld-%lld",
>> +			 (long long)offset, (long long)(offset + =
(off_t)length - 1));
>> +	else
>> +		snprintf(rangehdr, sizeof(rangehdr), "Range: =
bytes=3D%lld-",
>> +			 (long long)offset);
>> +
>> +	if (ctx->auth_header && strstr(ctx->auth_header, "Bearer"))
>> +		req.headers =3D curl_slist_append(req.headers, =
ctx->auth_header);
>> +	req.headers =3D curl_slist_append(req.headers, rangehdr);
>> +
>> +	curl_easy_reset(ctx->curl);
>> +
>> +	ret =3D ocierofs_curl_setup_common_options(ctx->curl);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret =3D ocierofs_curl_setup_rq(ctx->curl, req.url, =
OCIEROFS_HTTP_GET,
>> +				     req.headers,
>> +				     ocierofs_write_callback,
>> +				     &resp, NULL, NULL);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret =3D ocierofs_curl_perform(ctx->curl, &http_code);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (http_code =3D=3D 206) {
>> +		*out_buf =3D resp.data;
>> +		*out_size =3D resp.size;
>> +		resp.data =3D NULL;
>> +		ret =3D 0;
>> +	} else if (http_code =3D=3D 200) {
>=20
> 		ret =3D 0;
>=20
>> +		if (!offset) {
>> +			*out_buf =3D resp.data;
>> +			*out_size =3D resp.size;
>> +			resp.data =3D NULL;
>> +			ret =3D 0;
>> +		} else {
>=20
> 		} else if (offset < resp.size) {
> 			available =3D resp.size - offset;
> 			...
> 		}
>=20
>> +			if (offset < resp.size) {
>> +				available =3D resp.size - offset;
>> +				copy_size =3D length ? min_t(size_t, =
length, available) : available;
>> +
>> +				*out_buf =3D malloc(copy_size);
>> +				if (!*out_buf) {
>> +					ret =3D -ENOMEM;
>> +					goto out;
>> +				}
>> +				memcpy(*out_buf, resp.data + offset, =
copy_size);
>> +				*out_size =3D copy_size;
>> +				ret =3D 0;
>> +			} else {
>> +				ret =3D 0;
>> +			}
>> +		}
>> +	} else {
>> +		erofs_err("HTTP range request failed with code %ld", =
http_code);
>> +		ret =3D -EIO;
>> +	}
>> +
>> +out:
>> +	if (req.headers)
>> +		curl_slist_free_all(req.headers);
>> +	free(req.url);
>> +	free(resp.data);
>> +	return ret;
>> +}
>> +
>=20
> ...
>=20
>> diff --git a/mount/Makefile.am b/mount/Makefile.am
>> index d93f3f4..0b4447f 100644
>> --- a/mount/Makefile.am
>> +++ b/mount/Makefile.am
>> @@ -9,5 +9,5 @@ mount_erofs_SOURCES =3D main.c
>>  mount_erofs_CFLAGS =3D -Wall -I$(top_srcdir)/include
>>  mount_erofs_LDADD =3D $(top_builddir)/lib/liberofs.la =
${libselinux_LIBS} \
>>  	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
>> -	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS}
>> +	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS} =
${openssl_LIBS}
>>  endif
>> diff --git a/mount/main.c b/mount/main.c
>> index 2826dac..359dbbf 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -15,6 +15,7 @@
>=20
> ...
>=20
>=20
>> +
>=20
>>    			err =3D IS_ERR(id) ? PTR_ERR(id) :
>> @@ -789,9 +887,19 @@ int main(int argc, char *argv[])
>>  	}
>>    	if (mountcfg.backend =3D=3D EROFSNBD) {
>> -		err =3D erofsmount_nbd(mountcfg.device, mountcfg.target,
>> -				     mountcfg.fstype, mountcfg.flags,
>> -				     mountcfg.options);
>> +		if (mountcfg.use_oci) {
>> +			struct erofs_vfile vfile =3D {};
>=20
> Could you just move this to
> 	ocierofs_io_open() instead?
>=20
> e.g.
> 	vfile =3D (struct erofs_vfile){.ops =3D &ocierofs_io_vfops};
> 	*(struct ocierofs_iostream **)vfile->payload =3D oci_iostream;
>=20
>> +
>> +			ocicfg.image_ref =3D mountcfg.device;
>> +			src.vf =3D &vfile;
>> +			err =3D erofsmount_nbd(src, EROFSNBD_SOURCE_OCI, =
mountcfg.target,
>> +					     mountcfg.fstype, =
mountcfg.flags, mountcfg.options);
>> +		} else {
>> +			src.device_path =3D mountcfg.device;
>> +			err =3D erofsmount_nbd(src, =
EROFSNBD_SOURCE_LOCAL, mountcfg.target,
>> +					     mountcfg.fstype, =
mountcfg.flags,
>> +					     mountcfg.options);
>> +		}
>=20
> I think you could just
>=20
> 		struct erofs_vfile vfile;
> 		int sourcetype;
>=20
> 		if (mountcfg.use_oci) {
> 			sourcetype =3D EROFSNBD_SOURCE_OCI;
> 			ocicfg.image_ref =3D mountcfg.device;
> 			src.vf =3D &vfile;
> 		} else {
> 			sourcetype =3D EROFSNBD_SOURCE_LOCAL;
> 			src.device_path =3D mountcfg.device;
> 		}
>=20
> 		err =3D erofsmount_nbd(src, sourcetype, mountcfg.target,
> 				     mountcfg.fstype, mountcfg.flags,
> 				     mountcfg.options);
>=20
> Thanks,
> Gao Xiang
>=20
>>  		goto exit;
>>  	}
>> =20


